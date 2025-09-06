# Fastify + TypeScript 템플릿

간단하고 가벼운 Fastify + TypeScript 애플리케이션 템플릿입니다. 개발/빌드/배포에 필요한 스크립트와 멀티 스테이지 Dockerfile을 제공합니다.

## 특징

- Fastify v4 기반의 고성능 HTTP 서버
- TypeScript로 엄격 모드(Strict) 설정 및 타입 안전성 강화
- 개발용 `tsx` 워처로 빠른 개발 경험 제공
- ESLint + Prettier 구성
- 멀티 스테이지 Dockerfile로 효율적인 이미지 빌드

## 디렉터리 구조

```text
.
├─ src/
│  ├─ app.ts        # 앱 빌더(테스트/임베딩 용), 단독 실행도 가능
│  └─ server.ts     # 주 실행 진입점(개발/빌드 후 실행 스크립트 대상)
├─ dist/            # TypeScript 빌드 결과물 (tsc)
├─ .env.example     # 환경 변수 예시
├─ tsconfig.json    # TypeScript 컴파일 설정
├─ package.json     # 스크립트 및 의존성 관리
└─ Dockerfile       # 멀티 스테이지 Docker 빌드 스크립트
```

## 요구 사항

- Node.js >= 18 (권장: 최신 LTS)
- pnpm (Corepack 사용 시 자동 활성화 가능)

## 설치

```bash
pnpm install
```

## 스크립트

- 개발 모드(자동 재시작):

```bash
pnpm dev
# 내부적으로: tsx watch src/server.ts
```

- 타입 검사만:

```bash
pnpm type-check
```

- 린트:

```bash
pnpm lint
pnpm lint:fix
```

- 포맷팅:

```bash
pnpm format
```

- 빌드(컴파일):

```bash
pnpm build
# 결과물: dist/
```

- 빌드 결과 실행:

```bash
pnpm start
# 내부적으로: node dist/server.js
```

## 셸별 명령 예시 (PowerShell / Bash)

다음 예시는 PowerShell(Windows)과 Bash(Linux/macOS)에서 각각 동작하는 형태로 제공합니다.

### 1) 환경 변수 일시 설정 후 실행

- PowerShell

```powershell
$env:PORT = 4000
$env:HOST = "0.0.0.0"
pnpm dev
```

- Bash

```bash
PORT=4000 HOST=0.0.0.0 pnpm dev
```

환경 변수를 일시적으로만 적용하고 싶다면, PowerShell은 해당 세션에서만 유효하며 새 세션을 열면 초기화됩니다. Bash는 같은 라인에서만 유효합니다.

### 2) cURL(HTTP 요청) 예시

- PowerShell (Invoke-RestMethod 권장)

```powershell
irm http://localhost:3000/health
irm http://localhost:3000/
```

참고: PowerShell의 `curl` 별칭은 `Invoke-WebRequest`로 매핑되어 객체를 반환합니다. 간단한 JSON 확인에는 `irm`(Invoke-RestMethod) 사용을 권장합니다.

- Bash

```bash
curl http://localhost:3000/health
curl http://localhost:3000/
```

### 3) Docker 컨테이너 실행 (멀티라인 예시)

- PowerShell (백틱 ` 으로 줄바꿈)

```powershell
docker run --rm -p 3000:3000 `
  -e NODE_ENV=production `
  -e PORT=3000 `
  -e HOST=0.0.0.0 `
  fastify-ts-app node dist/server.js
```

- Bash (역슬래시 \ 로 줄바꿈)

```bash
docker run --rm -p 3000:3000 \
  -e NODE_ENV=production \
  -e PORT=3000 \
  -e HOST=0.0.0.0 \
  fastify-ts-app node dist/server.js
```

### 4) 터미널 출력 정리

- PowerShell

```powershell
cls
```

- Bash

```bash
clear
```

## 환경 변수

`.env.example`를 참고하여 `.env` 파일을 생성하세요.

```
NODE_ENV=development
PORT=3000
HOST=localhost
LOG_LEVEL=info
```

- `PORT`: 서버 포트 (기본 3000)
- `HOST`: 서버 바인딩 호스트(개발: `localhost`, 컨테이너/서버: `0.0.0.0` 권장)
- `LOG_LEVEL`: 로그 레벨(`info`, `debug` 등)

참고: `src/server.ts`는 `.env`를 로드하여 `HOST`, `PORT`를 사용하고, `src/app.ts`는 단독 실행 시 `0.0.0.0`로 바인딩합니다. 일반적으로 개발/운영은 `server.ts` 진입점을 사용합니다.

## API 엔드포인트

- 헬스 체크:
  - `GET /health`
  - 응답 예시:

    ```json
    { "status": "OK", "timestamp": "2024-01-01T00:00:00.000Z" }
    ```

- 루트:
  - `GET /`
  - `src/server.ts` 실행 시 응답 예시:

    ```json
    { "message": "TypeScript와 Fastify가 준비되었습니다!" }
    ```

  - `src/app.ts` 단독 실행 시 응답 예시:

    ```json
    { "message": "Hello Fastify!" }
    ```

cURL 예시:

- PowerShell

```powershell
irm http://localhost:3000/health
irm http://localhost:3000/
```

- Bash

```bash
curl http://localhost:3000/health
curl http://localhost:3000/
```

## 개발 팁

- Windows PowerShell에서 로그가 길게 누적되면 가독성을 위해 `clear`로 이전 출력 정리 후 다시 실행하세요.
- `@fastify/schema`는 존재하지 않는 패키지이므로 의존성에서 제거되었습니다. 또한 `dotenv`는 타입 정의를 내장하므로 `@types/dotenv`는 불필요합니다.

## Docker 사용법

Dockerfile은 4개 스테이지로 구성되어 있습니다.

1) pnpm 설치 및 의존성 설치 (deps)
2) TypeScript 빌드 (builder)
3) 런타임 최소화 (runtime)
4) 포트 노출 및 실행 설정

이미지 빌드:

```bash
docker build -t fastify-ts-app .
```

추가 빌드 옵션 예시:

- 캐시 없이 빌드

```bash
docker build --no-cache -t fastify-ts-app .
```

- 멀티 아키텍처 빌드(buildx) 예시 (로컬에서 테스트 시 선택 사항)

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t fastify-ts-app:multi .
```

컨테이너 실행:

- Dockerfile에 기본 CMD가 없다면 다음처럼 명령을 지정하세요.

- PowerShell

```powershell
docker run --rm -p 3000:3000 `
  -e NODE_ENV=production `
  -e PORT=3000 `
  -e HOST=0.0.0.0 `
  fastify-ts-app node dist/server.js
```

- Bash

```bash
docker run --rm -p 3000:3000 \
  -e NODE_ENV=production \
  -e PORT=3000 \
  -e HOST=0.0.0.0 \
  fastify-ts-app node dist/server.js
```

컨테이너 로그/정지/삭제:

```bash
# 로그 스트리밍
docker logs -f <container_id_or_name>

# 컨테이너 중지 후 삭제
docker stop <container_id_or_name>
docker rm <container_id_or_name>
```

환경 파일(.env) 사용 예:

- PowerShell

```powershell
docker run --rm -p 3000:3000 --env-file .\.env fastify-ts-app node dist/server.js
```

- Bash

```bash
docker run --rm -p 3000:3000 --env-file ./.env fastify-ts-app node dist/server.js
```

이미지/컨테이너 정리(선택):

```bash
# 중간 빌드 캐시 정리
docker builder prune

# 사용하지 않는 이미지/컨테이너/네트워크 정리
docker system prune -f
```

컨테이너 내에서 Fastify는 `HOST=0.0.0.0`으로 바인딩하는 것을 권장합니다.

## 기술 스택

- Fastify ^4
- TypeScript ^5
- tsx (개발용 실행/워치)
- ESLint ^9, Prettier ^3
- pnpm (패키지 매니저)

## 트러블슈팅

- 설치 시 404(@fastify/schema):
  - `@fastify/schema`는 npm 레지스트리에 존재하지 않습니다. 의존성에서 제거했습니다.
- `@types/dotenv` 경고:
  - `dotenv`가 자체 타입을 제공하므로 `@types/dotenv`는 설치하지 않습니다.
- 포트 점유 오류:
  - `PORT`를 변경하거나, 해당 포트를 사용 중인 프로세스를 종료하세요.
- Docker 컨테이너가 즉시 종료:
  - Dockerfile에 CMD가 없으므로 `node dist/server.js`를 명령으로 지정하여 실행하세요.

## 라이선스

- ISC
