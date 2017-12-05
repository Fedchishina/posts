<?php
/**
 * Created by PhpStorm.
 * User: Developer
 * Date: 05.12.2017
 * Time: 10:40
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
class PostLike extends Model
{
    protected $table = 'posts_likes';

    protected $fillable = [
        'post_id',
        'user_id',
    ];
}