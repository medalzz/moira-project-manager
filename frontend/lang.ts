import { createI18n } from 'vue-i18n';

import enUS from '@/lang/strings_en_us.json';
import ptBR from '@/lang/strings_pt_br.json';

export type Locale = 'pt-BR' | 'en-US';

export const i18n = createI18n({
    legacy: false,
    locale: 'pt-BR',
    fallbackLocale: 'en-US',

    messages: {
        'pt-BR': ptBR,
        'en-US': enUS,
    },
});

export function getLocale(): Locale {
    return i18n.global.locale.value;
}

export function setLocale(locale: Locale) {
    i18n.global.locale.value = locale;
    document.documentElement.lang = locale;
}
