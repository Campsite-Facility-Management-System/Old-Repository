<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Campsite;
use App\Models\Image;
use App\Models\User;
use Storage;
use JWTAuth;

class CampsiteController extends Controller
{
   public function create(Request $request){
    try {
        if(JWTAuth::parseToken()->authenticate()->type->type === "운영자"){
            $campsite = new Campsite;
            $campsite->owner_id = JWTAuth::parseToken()->authenticate()->email; 
            $campsite->name = $request->name;
            $campsite->telephone = $request->telephone;
            $campsite->address = $request->address;
            $campsite->description = $request->description;
            $campsite->save();
            for($i=0; $i<count($request->img);$i++){
                $img = new Image;
                $img->img_file_name = Storage::put('/public/img',$request->img[$i]);
                $img->img_url = Storage::url($img->img_file_name);
                $img->type = 'campsite';
                $img->index = $campsite->id;
                $img->save();
            }
            
            return response([
                'status' => 'success',
            ], 200);
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

   public function ownCampsiteList(Request $request){

    try {
        if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
            $campsite=Campsite::where('owner_id',JWTAuth::parseToken()->authenticate()->email)->get();
            for($i = 0; $i < count($campsite); $i++){
                $url=Image::where('type','campsite')->where('index',$campsite[$i]->id)->first();
                $campsite[$i]->img_url=$url["img_url"];
            }
            
            return response()->json($campsite);
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
