<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\OrderDetail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class OrderDetailController extends Controller
{
    public function index($order_id){
        $orderDetails = OrderDetail::where('order_id',$order_id)
                        ->with('product','product.category')->get();
        
        if(count($orderDetails) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $orderDetails
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
            'order_id' => 'required',
            'product_id' => 'required',
            'quantity' => 'required',
            'variance' => 'required',
            'subtotal' => 'required',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $orderdetail = OrderDetail::create($storeData);
        return response([
            'message' => 'Add orderdetail Success',
            'data' => $orderdetail
        ],200);

    }

    public function destroy($id){
        $orderdetail = OrderDetail::find($id);
        if(is_null($orderdetail)){
            return response([
                'message' => 'orderdetail Not Found',
                'data' => null
            ],404);
        }

        if($orderdetail->delete()){
            return response([
                'message' => 'Delete orderdetail Success',
                'data' => $orderdetail
            ],200);
        }

        return response([
            'message' => 'Delete orderdetail Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $orderdetail = OrderDetail::find($id);
        if(is_null($orderdetail)){
            return response([
                'message' => 'orderdetail Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        $validate =  Validator::make($updateData,[
            'quantity' => 'required',
            'variance' => 'required',
            'subtotal' => 'required',
        ]);

        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $orderdetail->quantity = $updateData['quantity'];
        $orderdetail->variance = $updateData['variance'];
        $orderdetail->subtotal = $updateData['subtotal'];

        if($orderdetail->save()){
            return response([
                'message' => 'Update OrderDetail Success',
                'data' => $orderdetail
            ],200);
        }

        return response([
            'message' => 'Update OrderDetail Failed',
            'data' => null
        ],400);
    }
}