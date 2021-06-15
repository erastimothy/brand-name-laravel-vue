<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Cart;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class CartController extends Controller
{
    public function index(){
        $carts = Cart::where('user_id',Auth::user()->id)->with('product')->get();
        
        if(count($carts) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $carts
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function show($id){
        $cart = Cart::find($id);

        if(!is_null($cart)){
            return response([
                'message' => 'Retrive All Success',
                'data' => $cart
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
            'product_id' => 'required',
            'quantity' => 'required',
            'variance' => 'required',
            'subtotal' => 'required',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        $storeData['user_id'] = Auth::user()->id;
        
        if($cart = Cart::where('variance',$request->variance)->where('product_id',$request->product_id)->first()){
            $cart->quantity = $cart->quantity+$request->quantity;
            $cart->subtotal = $request->subtotal;
            $cart->save();
        }else{
            $cart = Cart::create($storeData);
        }

        return response([
            'message' => 'Add cart Success',
            'data' => $cart
        ],200);

    }

    public function destroy($id){
        $cart = Cart::find($id);
        if(is_null($cart)){
            return response([
                'message' => 'cart Not Found',
                'data' => null
            ],404);
        }

        if($cart->delete()){
            return response([
                'message' => 'Delete cart Success',
                'data' => $cart
            ],200);
        }

        return response([
            'message' => 'Delete cart Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $cart = Cart::find($id);
        if(is_null($cart)){
            return response([
                'message' => 'cart Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        $validate =  Validator::make($updateData,[
            'product_id' => 'required',
            'quantity' => 'required',
            'variance' => 'required',
            'subtotal' => 'required',
        ]);

        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $cart->product_id = $updateData['product_id'];
        $cart->quantity = $updateData['quantity'];
        $cart->variance = $updateData['variance'];
        $cart->subtotal = $updateData['subtotal'];

        if($cart->save()){
            return response([
                'message' => 'Update Cart Success',
                'data' => $cart
            ],200);
        }

        return response([
            'message' => 'Update Cart Failed',
            'data' => null
        ],400);
    }
}
