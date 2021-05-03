<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PhpMqtt\Client\Facades\MQTT;
use App\Jobs\MqttSubscriber;

class MqttController extends Controller
{
    public function publishMqtt(Request $request,$topic,$msg){
    
        $mqtt = MQTT::connection();
        $mqtt->publish($topic, $msg);

        if($mqtt == true) 
            return response()->json(['message' => 'success'], 200);
        else 
            return response()->json('error', 404);
        
    }
  
    public function subscribeMqtt(Request $request,$topic){

        MqttSubscriber::dispatch();
        return response()->json('dd', 200);
    }
    
}
