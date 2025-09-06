# Use a specific SBCL version
####################################################################################################
# 멀티스테이지 빌드 구성
# - builder: 빌드/의존성 설치 전용 (apt, git 등 포함)
# - runtime: 실행 전용, 빌드 의존성 제거로 이미지 최소화
#
# 최적화 포인트
# 1) 레이어 캐시 최적화: apt 설치, Quicklisp 설치, 의존성 프리로드를 소스 복사 이전에 수행
# 2) 패키지 복원 분리: Quicklisp 설치와 의존성 로드를 빌드 단계에서만 수행
# 3) 빌드 아티팩트 최소화: 런타임에는 Quicklisp과 앱 소스/컴파일 산출물만 복사
# 4) 슬림 런타임: 동일한 sbcl slim 베이스로, 추가 패키지 미설치
####################################################################################################

# =========================
# 1) Builder Stage
# =========================
FROM daewok/sbcl:2.5.8-slim AS builder

# --- 시스템 패키지 설치 (빌드 단계에만 존재)
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates curl git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# --- Quicklisp 설치 (캐시 보존을 위해 소스 이전 단계)
COPY quicklisp.lisp /root/quicklisp.lisp
# ~/.quicklisp 경로에 설치하여 사용자 홈에 고정
RUN sbcl --non-interactive \
    --load /root/quicklisp.lisp \
    --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
    --eval '(ql:add-to-init-file)' \
    --eval '(quit)'

# --- 의존성 프리로드 (캐시 최대화)
# 필요한 라이브러리가 늘 경우 아래 quickload 목록에 추가하십시오.
RUN sbcl --non-interactive \
    --eval '(ql:quickload "hunchentoot")' \
    --eval '(quit)'

# --- 애플리케이션 소스 복사 (변경 잦음: 뒤쪽에 배치해 캐시 활용)
COPY src /root/src

# --- 선택: 주요 소스 컴파일로 런타임 스타트업 가속 (에러 무시 없이 실패 시 빌드 실패)
# 필요 시 컴파일 대상을 늘리십시오.
RUN sbcl --non-interactive \
    --eval '(compile-file "/root/src/main.lisp")' \
    --eval '(quit)'

# --- 런타임으로 넘길 최소 아티팩트만 정리해 복사할 디렉터리 구성
RUN mkdir -p /opt/app \
    && cp -r /root/src /opt/app/src \
    && cp -r /root/.quicklisp /opt/app/quicklisp


# =========================
# 2) Runtime Stage
# =========================
FROM daewok/sbcl:2.5.8-slim AS runtime

WORKDIR /root

# --- 빌드 산출물만 복사 (apt/git 등 미포함)
COPY --from=builder /opt/app/quicklisp /root/.quicklisp
COPY --from=builder /opt/app/src /root/src

# --- 메타데이터 라벨
LABEL org.opencontainers.image.source="https://github.com/mingyuchoo/docker-files" \
      org.opencontainers.image.title="hunchentoot-web-app" \
      org.opencontainers.image.description="SBCL + Hunchentoot 웹 애플리케이션 (멀티스테이지 최적화)"

# --- 컨테이너 시작 명령
# 필요 시 Hunchentoot가 사용하는 포트를 EXPOSE로 명시하십시오 (예: EXPOSE 8080)
# EXPOSE 8080
CMD ["sbcl", "--non-interactive", "--load", "/root/src/main.lisp"]
