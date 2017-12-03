<?php
namespace App\Controllers;
use App\Models\Category;
use App\Models\Post;

class PostsController extends Controller
{
    private $countTake = 4;

    public function actionIndex()
    {
        $categories = Category::get();
        $currentPage = isset($_GET['page']) ?: 1;
        $posts = Post::skip($this->getSkip($currentPage))->take($this->countTake);
        if (isset($_GET['category_id'])) {
            $posts->where('category_id', $_GET['category_id']);
        }
        $posts = $posts->get();
        $this->render('index', compact('categories', 'posts'));
    }

    private function getSkip($current)
    {
        return ($current - 1) * $this->countTake;
    }

}