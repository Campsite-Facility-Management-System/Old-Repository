<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Controller;
use App\Models\User;

class JWTAuthController extends Controller
{
    public function managerRegister(Request $request){
        $user = new User;
        $user->email = $request ->email;
        $user->password = Hash::make($request->password);
        $user->name = $request->name;
        $user->phone_number = $request->phone_number;
        $user->nick_name=$request->nick_name;
        $user->profile_img= '';
        $user->type = '운영자';
        $user->point = 0;
        $user->save();
        return response([
            'status' => 'success',
            'data' => $user
        ], 200);
    }
    public function userRegister(Request $request){
        $user = new User;
        $user->email = $request ->email;
        $user->password = Hash::make($request->password);
        $user->name = $request->name;
        $user->phone_number = $request->phone_number;
        $user->nick_name=$request->nick_name;
        $user->profile_img= '';
        $user->type = '사용자';
        $user->point = 0;
        $user->save();
        return response([
            'status' => 'success',
            'data' => $user
        ], 200);
    }
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        //$this->middleware('auth:api', ['except' => ['login']]);
        //creater this exception require ex)
        /*public function __construct()
         {
             $this->middleware(function ($request, $next) {
                 if ($request->route('method') != 'sendSMS') {
                     $this->middleware('auth:api');
                 }
                return $next($request);
            });
         }*/
        
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {
        $credentials = request(['email', 'password']);

        if (! $token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    public function check()
    {

        if (auth()->user()==null) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return response([
            'status' => 'success',
        ], 200);
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60
        ]);
    }
}
