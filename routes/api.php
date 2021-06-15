<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::post('register','Api\AuthController@register');
Route::post('login','Api\AuthController@login');
Route::get('email/verify/{id}','Api\VerificationController@verify')->name('verification.verify');


Route::get('product', 'Api\ProductController@index');
Route::get('product/search/{slug}', 'Api\ProductController@search');
Route::get('product/discover/{n}', 'Api\ProductController@discover');
Route::get('product/{id}', 'Api\ProductController@show');

Route::get('category', 'Api\CategoryController@index');
Route::get('category/{slug}/all', 'Api\CategoryController@showProducts');

Route::group(['middleware' => ['auth:api']], function () {
    Route::post('logout','Api\AuthController@logout');

    Route::resource('cart', 'Api\CartController');
    Route::resource('coupon', 'Api\CouponController');
    
    Route::resource('confirm-payment', 'Api\ConfirmPaymentController');
    
    Route::get('order-detail/{order_id}', 'Api\OrderDetailController@index');
    Route::post('order-detail','Api\OrderDetailController@store');
    Route::put('order-detail/{id}', 'Api\OrderDetailController@update');
    Route::delete('order-detail/{id}', 'Api\OrderDetailController@destroy');
    
    Route::resource('order', 'Api\OrderController');
    
    Route::post('category', 'Api\CategoryController@store');
    Route::put('category/{id}', 'Api\CategoryController@update');
    Route::delete('category/{id}', 'Api\CategoryController@destroy');

    Route::post('product', 'Api\ProductController@store');
    Route::delete('product/{id}', 'Api\ProductController@destroy');
    Route::put('product/{id}', 'Api\ProductController@update');

    Route::resource('role', 'Api\RoleController');

    Route::post('uploadImageProfile/{id}','Api\AuthController@uploadImageProfile');
    Route::put('user/{id}', 'Api\AuthController@updateUser');
});


Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
