<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Campsite;
use App\Models\Image;
use App\Models\User;
use App\Models\SiteType;
use App\Models\Device;
use Storage;
use JWTAuth;

class CampsiteController extends Controller
{
   public function create(Request $request){
    try {
        if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
            $campsite = new Campsite;
            $campsite->owner_id = JWTAuth::parseToken()->authenticate()->email; 
            $campsite->name = $request->name;
            $campsite->telephone = $request->telephone;
            $campsite->address = $request->address;
            $campsite->description = $request->description;
            $campsite->save();
            for($i=0; $i<count($request->img);$i++){
                $img = new Image;
                if(!Storage::has('/public/img/campsite'))
                    Storage::makeDirectory('/public/img/campsite');
                $img->img_file_name = Storage::put('/public/img/campsite',$request->img[$i]);
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
                if($url !=null)
                    $campsite[$i]->img_url=$url["img_url"];
            }
            
            return response()->json($campsite,200,[],)->setEncodingOptions(JSON_UNESCAPED_UNICODE) ;
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
   public function categoryList(Request $request){
        try {
            if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
                $campsite=Campsite::where('id',$request->campsite_id)->first();
                if($campsite != null && $campsite->owner_id == JWTAuth::parseToken()->authenticate()->email){
                    $siteType=siteType::where('campsite_id',$request->campsite_id)->get();
                    for($i = 0; $i < count($siteType); $i++){
                        $url=Image::where('type','site_type')->where('index',$siteType[$i]->id)->first();
                        if($url !=null)
                            $siteType[$i]->img_url=$url["img_url"];
                    }
                    return response()->json($siteType,200,[],)->setEncodingOptions(JSON_UNESCAPED_UNICODE) ;
                }
                else
                    return response()->json(['error' => 'Unauthorized1'], 401);
                
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
   public function categoryCreate(Request $request){
        try {
            if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
                $campsite=Campsite::where('id',$request->campsite_id)->first();

                if($campsite != null && $campsite->owner_id == JWTAuth::parseToken()->authenticate()->email){
                    $siteType = new SiteType;
                    $siteType->campsite_id = $request->campsite_id;
                    $siteType->name = $request->name;
                    $siteType->description = $request->description;
                    $siteType->price = $request->price;
                    $siteType->max_car_num = $request->max_car_num;
                    $siteType->max_adult_num = $request->max_adult_num;
                    $siteType->max_children_num = $request->max_children_num;
                    $siteType->max_energy = $request->max_energy;
                    $siteType->save();
                    for($i=0; $i<count($request->img);$i++){
                        $img = new Image;
                        if(!Storage::has('/public/img/category'))
                            Storage::makeDirectory('/public/img/category');
                        $img->img_file_name = Storage::put('/public/img/category',$request->img[$i]);
                        $img->img_url = Storage::url($img->img_file_name);
                        $img->type = 'site_type';
                        $img->index = $siteType->id;
                        $img->save();
                    }
                    return response([
                        'status' => 'success',
                    ], 200);
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

    public function deviceCreate(Request $request){
        try {
            if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
                $campsite=Campsite::where('id',$request->campsite_id)->first();
                $siteType=SiteType::where('id',$request->category_id)->first();

                if($campsite != null && $siteType != null &&  $campsite->owner_id == JWTAuth::parseToken()->authenticate()->email && $siteType->campsite_id == $request->campsite_id){
                    $device = new Device;
                    $device->campsite_id = $request->campsite_id;
                    $device->site_type_id = $request->category_id;
                    $device->uuid = $request->uuid;
                    $device->name = $request->name;
                    $device->state = 0;
                    $device->save();
                    return response([
                        'status' => 'success',
                    ], 200);
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

    public function deviceList(Request $request){
        try {
            if(JWTAuth::parseToken()->authenticate()->type === "운영자"){
                $campsite=Campsite::where('id',$request->campsite_id)->first();
                $siteType=SiteType::where('id',$request->category_id)->first();
                if($campsite != null && $siteType != null &&  $campsite->owner_id == JWTAuth::parseToken()->authenticate()->email && $siteType->campsite_id == $request->campsite_id){
                    $device = Device::where('campsite_id',$request->campsite_id)->where('site_type_id',$request->category_id)->get();
                    return response()->json($device,200,[],)->setEncodingOptions(JSON_UNESCAPED_UNICODE) ;
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
