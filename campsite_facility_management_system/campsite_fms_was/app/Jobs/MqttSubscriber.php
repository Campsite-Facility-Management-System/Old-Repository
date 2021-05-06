<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use PhpMqtt\Client\Facades\MQTT;
use App\Models\Device;
use App\Models\Electricity;
use Illuminate\Support\Facades\Log;

class MqttSubscriber implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    public $tries =5;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct()
    {
       $mqtt;
       $list;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $mqtt = MQTT::connection();
        $mqtt->subscribe('00000000-0000-0000-0000-000000000000', function (string $topic, string $message)  {
           // $mqtt->interrupt();
           $list = explode("\n",$message);
           //Log::info($list);

           switch($list[1]){
               case 'controll':
                    if($list[2]=='on'){
                        $device=Device::where('uuid',$list[0])->first();
                        $device->state = 1;
                        $device->save();
                    }else if($list[2]=='off'){
                        $device=Device::where('uuid',$list[0])->first();
                        $device->state = 0;
                        $device->save();
                    }
                    break;
                case 'sensing':
                    $device=Device::where('uuid',$list[0])->first();
                    $electricity = new Electricity;
                    $electricity->device_id=$device->id;
                    $electricity->watt = $list[2];
                    $electricity->save();
                    break;
           }
        }, 1);
        $mqtt->loop(true);    
    }
}
