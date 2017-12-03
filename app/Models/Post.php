<?php
/**
 * Created by PhpStorm.
 * User: Виктория
 * Date: 03.12.2017
 * Time: 19:12
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    protected $table = 'posts';

    protected $fillable = [
        'name',
        'description',
        'content',
        'category_id',
        'user_id'
    ];
}