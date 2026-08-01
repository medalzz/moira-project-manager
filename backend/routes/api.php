<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;

Route::prefix('v1')->group(function (): void {
    // Route::post('/login', [AuthController::class, 'login']);

    // Route::get('/users', function () {
    //     return DB::table('users')
    //         ->get()
    //         ->toJson();
    // });

    Route::middleware('auth:sanctum')->group(function (): void {
        // Route::post('/logout', [AuthController::class, 'logout']);

        // Route::get('/user', function (Request $request) {
        //     return $request->user();
        // });

        // Route::apiResource('projects', ProjectController::class);
    });
});