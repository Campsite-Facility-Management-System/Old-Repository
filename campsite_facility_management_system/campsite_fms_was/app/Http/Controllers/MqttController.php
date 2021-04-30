<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PhpMqtt\Client\Facades\MQTT;

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

        $mqtt = MQTT::connection();
        $mqtt->subscribe($topic, function (string $topic, string $message) use ($mqtt, &$result) {
            $result['topic'] = $topic;
            $result['message'] = $message;
            Log::info($message);
            //$mqtt->interrupt();
        }, 1);
        $mqtt->loop(true);
        return response()->json($result, 200);
    }

}
