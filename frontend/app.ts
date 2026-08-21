import './app.css';
import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { createApp, DefineComponent, h } from 'vue';
import { ZiggyVue } from '../vendor/tightenco/ziggy';
import { createI18n } from 'vue-i18n';

import ptBR from '@/lang/strings_pt_br.json';
import en from '@/lang/strings_en_us.json';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

const i18n = createI18n({
    legacy: false,
    locale: 'pt-BR',
    fallbackLocale: 'en',

    messages: {
        'pt-BR': ptBR,
        en,
    },
});

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) =>
        resolvePageComponent(
            `./Pages/${name}.vue`,
            import.meta.glob<DefineComponent>('./Pages/**/*.vue'),
        ),
    setup({ el, App, props, plugin }) {
        createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)
            .use(i18n)
            .mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});
