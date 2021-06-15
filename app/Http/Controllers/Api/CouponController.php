<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Coupon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CouponController extends Controller
{
    public function index(){
        $coupons = Coupon::all();
        
        if(count($coupons) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $coupons
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function show($c){
        $coupon = Coupon::where('name',$c)->first();

        if(!is_null($coupon)){
            return response([
                'message' => 'Retrive Coupon Success',
                'data' => $coupon
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
        
        $coupon = Coupon::create($storeData);
        return response([
            'message' => 'Add Role Success',
            'data' => $coupon
        ],200);

    }

    public function destroy($id){
        $coupon = Coupon::find($id);
        if(is_null($coupon)){
            return response([
                'message' => 'Role Not Found',
                'data' => null
            ],404);
        }

        if($coupon->delete()){
            return response([
                'message' => 'Delete Role Success',
                'data' => $coupon
            ],200);
        }

        return response([
            'message' => 'Delete Role Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $coupon = Coupon::find($id);
        if(is_null($coupon)){
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
        
        $coupon->name = $updateData['name'];
        
        if($coupon->save()){
            return response([
                'message' => 'Update Coupon Success',
                'data' => $coupon
            ],200);
        }

        return response([
            'message' => 'Update Coupon Failed',
            'data' => null
        ],400);
    }
}

