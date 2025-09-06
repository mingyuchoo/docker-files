# Set base image
FROM node:24-alpine3.21 AS base

# 공통 작업 디렉터리 설정
WORKDIR /app

# 스테이지 1) pnpm 설치 및 의존성 설치
FROM base AS deps
# corepack 활성화로 pnpm 사용
RUN corepack enable
COPY package.json ./
# lockfile이 있으면 복사 (없어도 빌드 가능하도록 처리)
COPY pnpm-lock.yaml* ./
# 의존성 설치 (lockfile 없을 시 생성 허용)
RUN pnpm install --frozen-lockfile=false

# 스테이지 2) TypeScript 빌드
FROM base AS builder
RUN corepack enable
COPY --from=deps /app/node_modules /app/node_modules
COPY --from=deps /app/pnpm-lock.yaml /app/pnpm-lock.yaml
COPY package.json ./
COPY tsconfig.json ./
COPY src ./src
RUN pnpm exec tsc

# 스테이지 3) 런타임 최소화
FROM node:24-alpine3.21 AS runtime
ENV NODE_ENV=production
WORKDIR /app
RUN corepack enable
COPY --from=deps /app/node_modules /app/node_modules
COPY package.json ./
COPY --from=builder /app/dist /app/dist

# 스테이지 4) 포트 노출 및 애플리케이션 실행
EXPOSE 3000

# 애플리케이션 실행
CMD ["node", "dist/server.js"]
