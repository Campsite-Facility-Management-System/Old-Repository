<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Campsite;
use App\Models\Image;
use App\Models\User;
use Storage;

class CampsiteController extends Controller
{
   public function create(Request $request){
    if(auth()->user()->type === "운영자"){
        $campsite = new Campsite;
        $campsite->owner_id = auth()->user()->email; 
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

   }

   public function ownCampsiteList(Request $request){
    if(auth()->user()->type === "운영자"){
        $campsite=Campsite::where('owner_id',auth()->user()->email)->get();
        $campsite[0]->img_url="http://exam.ac.kr";
        //return count($campsite);
        return response()->json($campsite);
    }
    return response()->json(['error' => 'Unauthorized'], 401);
    
   }

}
