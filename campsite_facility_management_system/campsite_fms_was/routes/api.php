<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JWTAuthController;
use App\Http\Controllers\Controller;
use App\Http\Controllers\CampsiteController;
use App\Http\Controllers\MqttController;
use App\Http\Controllers\DeviceController;
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

Route::post('category/manager/add',[CampSiteController::class,'categoryCreate']);
Route::post('category/manager/list',[CampSiteController::class,'categoryList']);

Route::post('device/manager/add',[CampSiteController::class,'deviceCreate']);
Route::post('device/manager/list',[CampSiteController::class,'deviceList']);

Route::post('device/manager/controll',[DeviceController::class,'deviceControll']);

Route::post('device/manager/energy/usage',[DeviceController::class,'energyUsage']);
Route::post('device/manager/energy/chart',[DeviceController::class,'energyChart']);
//Route::get('/mqtt/publish/{topic}/{message}', [MqttController::class,'publishMqtt']);
Route::get('/mqtt/subscriber/start', [MqttController::class,'subscribeMqtt']);