import Fastify, { FastifyInstance } from 'fastify';
import dotenv from 'dotenv';

// 환경 변수 로드 (개발 환경에서 사용)
dotenv.config();

// Fastify 인스턴스 생성
const fastify: FastifyInstance = Fastify({
  logger: true,
});

// 기본 라우트
fastify.get('/', async () => {
  // 간단한 헬스 메시지 반환
  return { message: 'TypeScript와 Fastify가 준비되었습니다!' };
});

// 헬스 체크 라우트
fastify.get('/health', async () => {
  return { status: 'OK', timestamp: new Date().toISOString() };
});

// 서버 시작 함수
const start = async (): Promise<void> => {
  try {
    const port = process.env.PORT ? parseInt(process.env.PORT, 10) : 3000;
    const host = process.env.HOST || '0.0.0.0';

    await fastify.listen({ port, host });
    console.log(`🚀 서버가 기동되었습니다: http://localhost:${port}`);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

// 우아한 종료 처리
const gracefulShutdown = async (): Promise<void> => {
  try {
    await fastify.close();
    console.log('서버가 정상적으로 종료되었습니다');
    process.exit(0);
  } catch (err) {
    console.error('종료 중 오류 발생:', err);
    process.exit(1);
  }
};

process.on('SIGINT', gracefulShutdown);
process.on('SIGTERM', gracefulShutdown);

// 진입점
start();
