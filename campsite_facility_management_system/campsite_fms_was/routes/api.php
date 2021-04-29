<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JWTAuthController;
use App\Http\Controllers\Controller;
use App\Http\Controllers\CampsiteController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group([

    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {

    Route::post('login', [JWTAuthController::class,'login']);
    Route::post('logout', [JWTAuthController::class,'logout']);
    Route::post('refresh', [JWTAuthController::class,'refresh']);
    Route::post('me', [JWTAuthController::class,'me']);
    Route::post('/manager/register',[JWTAuthController::class,'managerRegister']);
    Route::post('/user/register',[JWTAuthController::class,'userRegister']);
    Route::post('check', [JWTAuthController::class,'check']);

});

//Route::post('test',[Controller::class,'test']);
Route::post('campsite/manager/add',[CampSiteController::class,'create']);
Route::post('campsite/manager/list',[CampSiteController::class,'ownCampsiteList']);

