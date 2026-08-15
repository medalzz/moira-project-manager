import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';
import { fileURLToPath, URL } from 'node:url';

export default defineConfig({
    server: {
        host: '0.0.0.0',
        port: 5173,
        strictPort: true,
        origin: 'http://localhost:5173',
        cors: {
            origin: 'http://localhost:8000',
        },
        hmr: {
            host: 'localhost',
        },
    },

    plugins: [
        laravel({
            input: 'frontend/app.ts',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],

    resolve: {
        alias: {
            '@': fileURLToPath(new URL('./frontend', import.meta.url)),
        },

        tsconfigPaths: true,
    },
});
