<?php

return [
    'page_paths' => [
        base_path('frontend/Pages'),
    ],

    'testing' => [
        'ensure_pages_exist' => true,

        'page_paths' => [
            base_path('frontend/Pages'),
        ],

        'page_extensions' => [
            'js',
            'jsx',
            'svelte',
            'ts',
            'tsx',
            'vue',
        ],
    ],
];
