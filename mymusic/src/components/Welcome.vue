<template>
    <div>
        <a-carousel effect="fade" :autoplay="true">
            <div><img src='http://p1.music.126.net/J4kjxHVGlVqVrcDtbK4zAw==/109951164691443526.jpg?imageView&quality=89' alt="one"></div>
            <div><img src="http://p1.music.126.net/4xqTEeTAtbT_7dhUxMPPtg==/109951164691421791.jpg?imageView&quality=89" alt="two"></div>
            <div><img src="//y.gtimg.cn/music/common/upload/MUSIC_FOCUS/2023081.jpg?max_age=2592000" alt="three"></div>
            <div><img src="//y.gtimg.cn/music/common/upload/MUSIC_FOCUS/2029382.jpeg" alt="four"></div>
        </a-carousel>
        <div style="font-size: 20px;margin-top: 30px">音乐推荐</div>
        <a-divider />
        <a-row :gutter="[16,16]">
            <a-col :span="6"  v-for="(music,index) in musicList" :key="index">
                <a-card hoverable @click="toMusicInfo(music)" style="width: 200px" v-show="index<=7">
                    <img :alt="music.musicname" :src="music.musicimg"  slot="cover" style="height: 200px"/>
                    <a-card-meta>
                        <template slot="description"
                        >
                            <div  class="activeClass" style="text-align: center">{{music.musicname}}</div>
                            </template>
                    </a-card-meta>
                </a-card>
            </a-col>
        </a-row>
    </div>
</template>

<script>
    export default {
        name: "Welcome",
        data(){
          return{
              musicList:[]
          }
        },
        mounted:function () {
            this.getMusicList();
        },
        methods:{
            getMusicList:function () {
                this.axios.get('/user/getMusicList')
                .then(res=>{
                    this.musicList=res.data.data.slice(0,8);
                    console.log(this.musicList);
                }).catch(err=>{
                    console.log(err);
                })
            },
            toMusicInfo:function (music) {
                this.$router.push({path:'/musicInfo',query:{music:JSON.stringify(music)}})
            }
        }
    }
</script>

<style scoped>
    /* For demo */
    .ant-carousel >>> .slick-slide {
        text-align: center;
        height: 400px;
        width: 800px;
        line-height: 160px;
        background: #364d79;
        overflow: hidden;
    }

    .ant-carousel >>> .slick-slide h3 {
        color: #fff;
    }

   :hover.activeClass{
       color: #2d8cf0;
   }
</style>