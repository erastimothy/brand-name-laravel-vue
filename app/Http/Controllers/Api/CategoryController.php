<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Category;

class CategoryController extends Controller
{
    public function index(){
        $categories = Category::get();
        
        if(count($categories) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $categories
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }

    public function show($slug){
        $category = Category::with('products')->where('slug',$slug)->first();

        if(!is_null($category)){
            return response([
                'message' => 'Retrive Data Success',
                'data' => $category
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
            'image' => 'required|mimes:jpeg,jpg,png,gif',
        ]);
        
        if($validate->fails())
            return response(['message' => $validate->errors(),400]);

        $storeData['slug'] = \Str::slug($request->name);
        $img = $request->file('image')
        ->move(public_path("/images/category/"),$request->file('image')->getClientOriginalName());
        $img_name = $request->file('image')->getClientOriginalName();
        $storeData['image'] = $img_name;
       
        $category = Category::create($storeData);
        return response([
            'message' => 'Add category Success',
            'data' => $category
        ],200);

    }

    public function destroy($id){
        $category = Category::find($id);
        if(is_null($category)){
            return response([
                'message' => 'category Not Found',
                'data' => null
            ],404);
        }

        if($category->delete()){
            return response([
                'message' => 'Delete category Success',
                'data' => $category
            ],200);
        }

        return response([
            'message' => 'Delete category Failed',
            'data' => null
        ],400);
        
    }

    public function update(Request $request , $id){
        $category = Category::find($id);
        if(is_null($category)){
            return response([
                'message' => 'category Not Found',
                'data' => null
            ],404);
        }
        $updateData =  $request->all();
        $validate =  Validator::make($updateData,[
            'name' => 'required',
        ]);

        if($validate->fails())
            return response(['message' => $validate->errors(),400]);
        
        $category->name = $updateData['name'];
        $category->slug = \Str::slug($updateData['name']);

        if($category->save()){
            return response([
                'message' => 'Update Category Success',
                'data' => $category
            ],200);
        }

        return response([
            'message' => 'Update Category Failed',
            'data' => null
        ],400);
    }

    public function showProducts($slug){
        $categories = Category::where('slug',$slug)->with('products')->get();
        
        if(count($categories) > 0){
            return response([
                'message' => 'Retrive All Success',
                'data' => $categories
            ],200);
        }

        return response([
            'message' => 'Empty',
            'data' => null
        ],404);
    }
}
