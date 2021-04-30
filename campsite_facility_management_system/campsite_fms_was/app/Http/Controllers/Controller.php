<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Storage;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public function test(Request $request ){
       
       // Storage::put('/public/img',$request->name[2]);
       // Storage::put('/public/img',$request->name[0]);
       // return Storage::url('vofQW88Vs7JVA5Of4m6Hz5ikj6OProXQtmvPY7E0.jpg');
        return  auth('api')->user();
    }
}
