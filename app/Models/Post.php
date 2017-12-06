<?php
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

    /**
     * getting user, who created post
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    //----------------  validation functions  -----------------------//
    public static function checkName($name)
    {
        $length = strlen(trim($name));
        if(($length >= 2)&&($length<=240)) {
            return true;
        } else {
            return false;
        }
    }

    public static function checkDescription($description)
    {
        $length = strlen(trim($description));
        if(($length >= 2)&&( $length <= 240)) {
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

        $length = strlen(trim($content));

        if(($length > 6) && ($length <= 240)) {
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
            $errors['name'][] = 'имя должно быть не меньше 2 символов и не больше 240. Сейчас введено ' . strlen($params['name']);
        }
        if (!Post::checkDescription($params['description'])){
            $errors['description'][] = 'описание должно быть не меньше и не больше 240. Сейчас введено ' . strlen($params['description']);
        }
        if (!Post::checkContent($params['content'])){
            $errors['content'][] = 'контент должен быть не меньше 6 символов и не больше 240. Сейчас введено ' . strlen($params['content']);
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

    /*
     * getting count of likes by post
     */
    public function countLikes()
    {
        return PostLike::where('post_id', $this->id)->count();
    }
}