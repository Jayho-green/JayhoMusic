import Vue from 'vue'
import VueRouter from 'vue-router'
import ViewUI from "view-design";
Vue.use(VueRouter)
import Login from "@/views/Login";
import Home from "@/views/Home";
import UserInfo from "@/components/UserInfo";
import Music from "@/components/Music";
import Singer from "@/components/Singer";
import Welcome from "@/components/Welcome";
import MusicInfo from "@/components/MusicInfo";
import Search from "@/components/Search";
import SingerInfo from "@/components/SingerInfo";
import ListInfo from "@/components/ListInfo";
import SingerRequest from "@/components/SingerRequest";
import AdminPage from "@/components/AdminPage";
import AdminReview from "@/components/AdminReview";
import UploadMusic from "@/components/UploadMusic";

const routes = [
  {
    path: '/',
    redirect:'/login'
  },
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path:'/home',
    name:'home',
    component:Home,
    children:[
      {
        path:'/userInfo',
        name:'userInfo',
        component:UserInfo
      },
      {
        path:'/music',
        name:'music',
        component:Music
      },
      {
        path:'/welcome',
        name:'welcome',
        component:Welcome
      },
      {
        path:'/singer',
        name:'singer',
        component:Singer
      },
      {
        path:'/musicInfo',
        name:'musicInfo',
        component:MusicInfo
      },
      {
        path:'/search',
        name:'search',
        component:Search
      },
      {
        path:'/singerInfo',
        name:'singerInfo',
        component:SingerInfo
      },
      {
        path: '/listInfo',
        name:'listInfo',
        component: ListInfo
      },
      {
        path:'/singerRequest',
        name:'singerRequest',
        component: SingerRequest
      },
      {
        path:'/adminPage',
        name:'adminPage',
        component: AdminPage
      },
      {
        path:'/adminReview',
        name:'adminReview',
        component: AdminReview
      },
      {
        path:'/uploadMusic',
        name:'uploadMusic',
        component: UploadMusic
      }
    ]
  }
]

const router = new VueRouter({
  routes
});
//??????????????????
router.beforeEach((to, from, next) => {   //to?????????????????????url???from???????????????url????????????next????????????
  if (to.path === '/login') {    //????????????????????????????????????
    next();     //????????????
  }
  else if (to.path !== '/login'){   //????????????????????????????????????
    let token = localStorage.getItem('token');    //?????????????????????token???
    if (token===null||token===''){    //???token????????????????????????????????????????????????
      next('/login');
      ViewUI.Message.warning('?????????')
    }
    else{           //????????????????????????
      next();
    }
  }
  else{
    next();
  }
});
router.afterEach((to,form) => {
});

export default router
