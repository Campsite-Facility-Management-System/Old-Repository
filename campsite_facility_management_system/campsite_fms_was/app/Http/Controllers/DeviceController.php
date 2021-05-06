<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PhpMqtt\Client\Facades\MQTT;
use Illuminate\Support\Facades\Auth;
use App\Models\Campsite;
use App\Models\Image;
use App\Models\User;
use App\Models\SiteType;
use App\Models\Device;
use App\Models\DeviceLog;
use App\Models\Electricity;
use JWTAuth;
use Carbon\Carbon;;

class DeviceController extends Controller
{
    public function deviceControll(Request $request){
        try {
            if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
                $device = Device::where('id',$request->device_id)->first();
                $siteType= SiteType::where('id',$device->site_type_id)->first();
                $campsite=Campsite::where('id',$siteType->campsite_id)->first();
                
                if($device !=null && $campsite != null && $campsite->owner_id == JWTAuth::parseToken()->authenticate()->email){
                    if($request->command ==1 || $request->command ==0 ){
                        if($request->command ==1 )
                            $command = "on";
                        else if($request->command == 0)
                            $command = "off";
                        $mqtt = MQTT::connection();
                        $mqtt->publish($device->uuid, $command);
                        $deviceLog= new DeviceLog;
                        $deviceLog->device_id = $device->id;
                        $deviceLog->user_id = JWTAuth::parseToken()->authenticate()->id;
                        $deviceLog->command = 'controll';
                        $deviceLog->contents = $request->command;
                        $deviceLog->save();

                        return response([
                            'status' => 'success',
                        ], 200);
                    }
                    else
                    response([
                        'error' => 'command invalid',
                    ], 500);
                }
                else
                    return response()->json(['error' => 'Unauthorized'], 401);
                
            }
            return response()->json(['error' => 'Unauthorized'], 401);
        
        } catch (\Tymon\JWTAuth\Exceptions\TokenExpiredException $e) {

            return response()->json(['error' => 'Expired'], 403);
        
        } catch (\Tymon\JWTAuth\Exceptions\TokenInvalidException $e) {
        
            return response()->json(['error' => 'Invalid'], 401);
        
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $e) {

            return response()->json(['error' => 'Unknown Error'], 402);

        }
    }

    public function energyUsage(Request $request){
        try {
            if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
                $device = Device::where('id',$request->device_id)->first();
                $siteType= SiteType::where('id',$device->site_type_id)->first();
                $campsite=Campsite::where('id',$siteType->campsite_id)->first();
                $now = Carbon::now();
                if($device !=null && $campsite != null && $campsite->owner_id == JWTAuth::parseToken()->authenticate()->email){
                    $electricity = Electricity::where('device_id',$device->id)->where('created_at','>',Carbon::now()->startOfMonth() )->get();
                    $usage=0.0;
                    for($i=0; $i<count($electricity);$i++){
                        $usage += $electricity[$i]->watt;
                    }
                    $charge =  ($usage/360000*54.2)+5550;
                    return response()->json(['usage'=>round($usage/360000,3),'charge'=>round($charge)],200)->setEncodingOptions(JSON_UNESCAPED_UNICODE) ;
                }
                else
                    return response()->json(['error' => 'Unauthorized'], 401);
                
            }
            return response()->json(['error' => 'Unauthorized'], 401);
        
        } catch (\Tymon\JWTAuth\Exceptions\TokenExpiredException $e) {

            return response()->json(['error' => 'Expired'], 403);
        
        } catch (\Tymon\JWTAuth\Exceptions\TokenInvalidException $e) {
        
            return response()->json(['error' => 'Invalid'], 401);
        
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $e) {

            return response()->json(['error' => 'Unknown Error'], 402);

        }
    }
    public function energyChart(Request $request){
        try {
            if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
                $device = Device::where('id',$request->device_id)->first();
                $siteType= SiteType::where('id',$device->site_type_id)->first();
                $campsite=Campsite::where('id',$siteType->campsite_id)->first();
                if($device !=null && $campsite != null && $campsite->owner_id == JWTAuth::parseToken()->authenticate()->email){
                    $electricity = Electricity::where('device_id',$device->id)->orderBy('created_at','desc')->select('watt','created_at')->limit(12)->get();
                    $temp =array();
                    for($i = 0 ; $i< 12; $i++){
                        array_push($temp,$electricity[$i]->watt);
                        //$electricity[$i]->created_at = Carbon::parse($electricity[$i]->created_at,'UTC')->format('Y-m-d H:i:s')->toAtomString();     
                    }
                        

                    return response()->json(['max'=>max($temp),'electricity'=>$electricity],200)->setEncodingOptions(JSON_UNESCAPED_UNICODE) ;
                }
                else
                    return response()->json(['error' => 'Unauthorized'], 401);
                
            }
            return response()->json(['error' => 'Unauthorized'], 401);
        
        } catch (\Tymon\JWTAuth\Exceptions\TokenExpiredException $e) {

            return response()->json(['error' => 'Expired'], 403);
        
        } catch (\Tymon\JWTAuth\Exceptions\TokenInvalidException $e) {
        
            return response()->json(['error' => 'Invalid'], 401);
        
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $e) {

            return response()->json(['error' => 'Unknown Error'], 402);

        }
    }
}
