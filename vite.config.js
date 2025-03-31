import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    open: true
  },
  build: {
    outDir: 'dist',
    assetsDir: 'assets'
  },
  publicDir: 'public',
  resolve: {
    alias: {
      '@': '/src'
    }
  }
});