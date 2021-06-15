<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProductController extends Controller
{
    public function index(){
        $products = Product::with('category')->get();
        
        if(count($products) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $products
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function show($id){
        $product = Product::with('category')->find($id);

        if(!is_null($product)){
            return response([
                'message' => 'Retrive Data Success',
                'data' => $product
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
            'description' => 'required',
            'image' => 'required|mimes:jpeg,jpg,png,gif',
            'category_id' => 'required',
            'price' => 'required',
            'stock' => 'required',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $img = $request->file('image')
        ->move(public_path("/images/products/"),$request->file('image')->getClientOriginalName());
        $img_name = $request->file('image')->getClientOriginalName();
        $storeData['image'] = $img_name;
        
        $product = Product::create($storeData);
        return response([
            'message' => 'Add product Success',
            'data' => $product
        ],200);

    }

    public function destroy($id){
        $product = Product::find($id);
        if(is_null($product)){
            return response([
                'message' => 'product Not Found',
                'data' => null
            ],404);
        }

        if($product->delete()){
            return response([
                'message' => 'Delete product Success',
                'data' => $product
            ],200);
        }

        return response([
            'message' => 'Delete product Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $product = Product::find($id);
        if(is_null($product)){
            return response([
                'message' => 'product Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        $validate =  Validator::make($updateData,[
            'name' => 'required',
            'description' => 'required',
            'category_id' => 'required',
            'price' => 'required',
            'stock' => 'required',
        ]);
        

        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        if($request->hasFile('image')){
            $img = $request->file('image')->move(public_path("/"),$request->file('image')->getClientOriginalName());
            $img_name = $request->file('image')->getClientOriginalName();
            $product->name = $img_name;
        }
        
        $product->name = $updateData['name'];
        $product->description = $updateData['description'];
        $product->category_id = $updateData['category_id'];
        $product->price = $updateData['price'];
        $product->stock = $updateData['stock'];
        
        if($product->save()){
            return response([
                'message' => 'Update Product Success',
                'data' => $product
            ],200);
        }

        return response([
            'message' => 'Update Product Failed',
            'data' => null
        ],400);
    }

    public function discover($n){
        $products = Product::inRandomOrder()->with('category')->limit($n)->get();
        
        if(count($products) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $products
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function search($q){
        if($q == "all"){
            $products = Product::inRandomOrder()->with('category')->get();
        }else{
            $products = Product::with('category')->where('name','like','%'.$q.'%')
            ->orWhere('price','like','%'.$q.'%')->get();
        }
        
        if($products->count() > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $products
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }
}
