import Fastify, { FastifyInstance } from 'fastify';

export const buildApp = (): FastifyInstance => {
  const fastify = Fastify({
    logger: {
      level: process.env.LOG_LEVEL || 'info',
    },
  });

  // 기본 라우트
  fastify.get('/', async () => {
    return { message: 'Hello Fastify!' };
  });

  // 추가 라우트/플러그인은 여기서 register
  // fastify.register(somePlugin)

  return fastify;
};

if (require.main === module) {
  const app = buildApp();

  const start = async (): Promise<void> => {
    try {
      const port = process.env.PORT ? parseInt(process.env.PORT, 10) : 3000;
      await app.listen({ port, host: '0.0.0.0' });
      console.log(`🚀 서버가 기동되었습니다: http://localhost:${port}`);
    } catch (err) {
      app.log.error(err);
      process.exit(1);
    }
  };

  start();
}
