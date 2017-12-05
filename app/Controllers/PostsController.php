<?php
namespace App\Controllers;
use App\Models\Category;
use App\Models\Post;
use App\Models\PostLike;

class PostsController extends Controller
{
    /*
     * GET - viewing main page with post list
     */
    public function actionIndex()
    {
        $allCount = isset($_GET['category_id']) ? Post::where('category_id', $_GET['category_id'])->count() : Post::count();

        $categories = Category::get();
        $currentPage = isset($_GET['page']) ? $_GET['page'] : 1;
        $posts = Post::skip($this->getSkip($currentPage))->take($this->countTake);
        if (isset($_GET['category_id'])) {
            $posts->where('category_id', $_GET['category_id']);
        }
        $posts = $posts->orderBy('created_at', 'desc')->get();
        $pages = $this->pages_array($allCount);
        $this->render('index', compact('categories', 'posts', 'pages'));
    }

    /**
     * GET - viewing page for adding of post
     * POST - adding of post in DB
     */
    public function actionAdd()
    {
        if (isset($_SESSION['auth'])) {
            if ($_SERVER['REQUEST_METHOD'] == 'GET') {
                $categories = Category::get();
                $this->render('pages/posts/add', compact('categories'));
            } else {
                $validateErrors = Post::validate($_POST);
                if (count($validateErrors) == 0){
                    Post::create([
                        'name' => $_POST['name'],
                        'description' => $_POST['description'],
                        'user_id' => $_SESSION['user_id'],
                        'content' => $_POST['content'],
                        'category_id' => $_POST['category_id'],
                    ]);
                    $message = 'Пост успешно добавлен';
                    header("Location: /?message=" . $message);
                } else {
                    $categories = Category::get();
                    $this->render('pages/posts/add', ['errors' => $validateErrors, 'inputs' => $_POST, 'categories'=>$categories]);
                }
            }
        } else {
            $this->render('pages/login');
        }

    }

    /**
     * GET - viewing page with detail info of post
     */
    public function actionShow()
    {
        if(isset($_GET['post_id'])){
            $post = Post::where('id', $_GET['post_id'])->first();
            if($post) {
                $this->render('pages/posts/index', compact('post'));
            }
        }
    }

    /**
     * GET - like/dislike of post
     */
    public function actionLike()
    {
        if ( !isset($_GET['post_id'])) {
            echo json_encode([
                'status' => false,
                'error' => 'отсутствует идентификатор поста'
            ]);
        }

        if ( !isset($_SESSION['user_id'])) {
            echo json_encode([
                'status' => false,
                'error' => 'пользователь не авторизован'
            ]);
        }

        $postLikes = PostLike::where('post_id', $_GET['post_id'])
            ->where('user_id', $_SESSION['user_id'])
            ->first();


        if ($postLikes <> null) {
            //dislike
            $postLikes->delete();
        } else {
            //like
            PostLike::create([
                'user_id' => $_SESSION['user_id'],
                'post_id' =>  $_GET['post_id']
            ]);
        }
        $countLikes = PostLike::where('post_id', $_GET['post_id'])->count();
        echo json_encode([
                'status' => true,
                'count_likes' => $countLikes
            ]);
    }

    /**
     * GET - viewing page with statistic info of post (likes)
     */
    public function actionStatistic()
    {
        if(isset($_GET['post_id'])) {
            $post = Post::where('id', $_GET['post_id'])->first();
            $postLikes = PostLike::where('post_id', $_GET['post_id'])->get();
            $this->render('pages/posts/statistic', compact('postLikes','post'));
        }
    }
}