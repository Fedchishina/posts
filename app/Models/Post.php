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

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    //----------------  validation functions  -----------------------//
    public static function checkName($name)
    {
        $length = strlen($name);
        if(($length > 2)&&($length<=80)) {
            return true;
        } else {
            return false;
        }
    }

    public static function checkDescription($description)
    {
        $length = strlen($description);
        if(($length > 2)&&($length<=80)) {
            return true;
        } else {
            return false;
        }
    }

    public static function checkCategory($category)
    {
        if(empty($category)||$category<=0) {
            return false;
        } else {
            return true;
        }
    }

    public static function checkContent($content)
    {
        $length = strlen($content);
        if(($length > 6) && ($length <= 80)) {
            return true;
        } else {
            return false;
        }
    }

    public static function checkUser()
    {
        if(strlen($_SESSION['auth'])) {
            return true;
        } else {
            return false;
        }
    }

    public static function validate($params) {
        $errors = [];
        if (!Post::checkName($params['name'])){
            $errors['name'][] = 'имя должно содержать не меньше 2 символов и не больше 80';
        }
        if (!Post::checkDescription($params['description'])){
            $errors['description'][] = 'описание должно содержать не меньше и не больше 80';
        }
        if (!Post::checkContent($params['content'])){
            $errors['content'][] = 'контент должен содержать не меньше 6 символов и не больше 80';
        }
        if (!Post::checkCategory($params['category_id'])){
            $errors['category_id'][] = 'категория поста не выбрана';
        }
        if (!Post::checkUser()){
            $errors['content'][] = 'пользователь не авторизован';
        }

        return $errors;
    }
    //-----------------------------------------------------------------------

    public function countLikes()
    {
        return PostLike::where('post_id', $this->id)->count();
    }
}