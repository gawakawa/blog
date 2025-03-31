// このファイルは開発用のエントリポイントです
import { main } from './output/Main/index.js';

if (import.meta.hot) {
  import.meta.hot.accept(() => {
    console.log('Module updated, reloading...');
    main();
  });
}

// アプリケーションの実行
main();