<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\User;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller 
{
    public function register(Request $request){

        $registrationData = $request->all();
       
        $validate = Validator::make($registrationData, [
            'name' => 'required|max:60',
            'email' => 'required|email:rf,dns|unique:users',
            'password' => 'required',
            'phoneNumber'  => 'required',
        ]); 

        if($validate->failed())
            return response(['message' => $validate->errors()],404);

        $registrationData['password'] = bcrypt($request->password);

        try{ // unique email validation
            $user = User::create($registrationData)->sendEmailVerificationNotification();
        }catch(\Illuminate\Database\QueryException $e){
            return response(['message' => 'email has been registered'],401);
        }

        return response([
            'message' => 'Register Success, Please Verif your email first',
            'user' => $user,
        ],200);
    }

    public function logout (Request $request) 
    {
        $token = $request->user()->token();
        $token->revoke();
        return response()->json([
            'message' => 'Successfully logged out',
        ],200);
    
    }

    public function login(Request $request){
        $loginData = $request->all();
        $validate = Validator::make($loginData, [
            'email' => 'required|email:rf,dns|unique:users',
            'password' => 'required',
        ]);
        if($validate->failed())
            return response(['message' => $validate->errors()],404);
        if(!Auth::attempt($loginData))
            return response(['message' => 'Invalid Credentials'],401);
        
        $user = Auth::user();
        if(!$user->hasVerifiedEmail()){
            return response(['message' => 'Verif your email first'],402);
        }
        $token =  $user->createToken('Authentication Token')->accessToken;

        $user['role'] = $user->role;
        return response([
            'message' => 'Login Success',
            'data' => $user,
            'token_type' => 'Bearer',
            'access_token' => $token,
        ],200);
    }

    public function uploadImageProfile(Request $request, $id){
        if($request->hasFile('image')){
            $user = User::find($id);
            
            //$img = $request->file('image')->move(public_path("/images/"),$request->file('image')->getClientOriginalName());
            $path = Storage::putFile('public/users/',$request->file('image'));
            $img_name = 'users/'.$request->file('image')->getClientOriginalName();

            $user->photoProfile = $img_name;
            if($user->save()){
                return response([
                    'message' => 'Upload user image success',
                    'user' => $user
                ],200);
            }
        }else {
            return response([
                'message' => 'image not found',
            ],400);
        }

    }

    public function updateUser(Request $request , $id){
        $user = User::find($id);
        if(is_null($user)){
            return response([
                'message' => 'user Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        
        $validate =  Validator::make($updateData,[
            'name' => 'max:60',
            'email' => 'email',
            'umur' => 'numeric',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);

        if($user->update($updateData)){
            return response([
                'message' => 'Update user Success',
                'data' => $user
            ],200);
        }

        return response([
            'message' => 'Update user Failed',
            'data' => null
        ],400);
    }

    public function deleteUser($id){
        $user = User::find($id);
        if(is_null($user)){
            return response([
                'message' => 'User Not Found',
                'data' => null
            ],404);
        }

        if($user->delete()){
            return response([
                'message' => 'Delete User Success',
                'data' => $user
            ],200);
        }

        return response([
            'message' => 'Delete User Failed',
            'data' => null
        ],400);
        
    }
}
