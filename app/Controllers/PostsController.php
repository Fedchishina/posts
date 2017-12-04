<?php
namespace App\Controllers;
use App\Models\Category;
use App\Models\Post;

class PostsController extends Controller
{
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
                    $this->render('pages/posts/add', ['errors' => $validateErrors, 'inputs' => $_POST]);
                }
            }
        } else {
            $this->render('pages/login');
        }

    }

    public function actionShow()
    {
        if(isset($_GET['post_id'])){
            $post = Post::where('id', $_GET['post_id'])->first();
            if($post) {
                $this->render('pages/posts/index', compact('post'));
            }
        }
    }
}