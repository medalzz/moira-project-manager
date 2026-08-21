export interface User {
    id: number;
    name: string;
    username: string;
    email: string;
    locale: 'pt-BR' | 'en-US';
    email_verified_at?: string;
}

export type PageProps<
    T extends Record<string, unknown> = Record<string, unknown>,
> = T & {
    auth: {
        user: User;
    };
};
