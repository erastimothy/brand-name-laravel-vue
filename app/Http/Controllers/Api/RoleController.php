<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use TCG\Voyager\Models\Role;

class RoleController extends Controller
{
    public function index(){
        $roles = Role::all();
        
        if(count($roles) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $roles
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function show($id){
        $role = Role::find($id);

        if(!is_null($role)){
            return response([
                'message' => 'Retrive All Success',
                'data' => $role
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function store(Request $request){
        $storeData =  $request->all();
        $validate =  Validator::make($storeData,[
            'name' => 'required',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $role = Role::create($storeData);
        return response([
            'message' => 'Add Role Success',
            'data' => $role
        ],200);

    }

    public function destroy($id){
        $role = Role::find($id);
        if(is_null($role)){
            return response([
                'message' => 'Role Not Found',
                'data' => null
            ],404);
        }

        if($role->delete()){
            return response([
                'message' => 'Delete Role Success',
                'data' => $role
            ],200);
        }

        return response([
            'message' => 'Delete Role Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $role = Role::find($id);
        if(is_null($role)){
            return response([
                'message' => 'Role Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        $validate =  Validator::make($updateData,[
            'name' => 'required',
        ]);

        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $role->name = $updateData['name'];
        
        if($role->save()){
            return response([
                'message' => 'Update Role Success',
                'data' => $role
            ],200);
        }

        return response([
            'message' => 'Update Role Failed',
            'data' => null
        ],400);
    }
}
