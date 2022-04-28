<template>
    <div>
        <a-card style="height:100%">
            <div v-show="singerList.length>0">
      <span  style="margin-top: 30px;font-size: 20px;">相关歌手</span>
            <a-divider/>
                <div v-for="(singer,index) in singerList" :key="index" style="margin-top: 20px">
                <img @click="toSingerInfo(singer.singerid)" class="activeClass" :src="singer.singerimg" height="30%" width="30%" :alt="singer.singername">
                    <span @click="toSingerInfo(singer.singerid)" class="activeClass" style="font-size: 30px;margin-left: 20%">{{singer.singername}}</span>
                    <a-divider></a-divider>
                </div>
            </div>
            <div v-show="musicList.length>0">
        <span style="margin-top: 30px;font-size: 20px;">相关音乐</span>
            <a-divider/>
                <div v-for="(music,index) in musicList" :key="index" style="margin-top: 20px">
                    <img @click="toMusicInfo(music)" class="activeClass" :src="music.musicimg" height="200px" width="200px" :alt="music.musicname">
                    <span @click="toMusicInfo(music)" class="activeClass" style="font-size: 30px;margin-left: 20%">{{music.musicname}}</span>
                    <a-divider></a-divider>
                </div>
            </div>
        </a-card>
    </div>
</template>

<script>
    export default {
        name: "Search",
        data(){
            return{
                musicList:[],
                singerList:[]
            }
        },
        mounted:function () {
            let result=JSON.parse(this.$route.query.searchResult);
                this.singerList=result.singerList;
                this.musicList=result.musicList;
        },
        watch:{
            $route(){    //监听路由参数变化
                this.musicList=JSON.parse(this.$route.query.searchResult).musicList;
                this.singerList=JSON.parse(this.$route.query.searchResult).singerList;
            }
        },
        methods:{
            toMusicInfo:function (music) {
                this.$router.push({path:'/musicInfo',query:{music:JSON.stringify(music)}})
            },
            toSingerInfo:function (singerid) {
                this.$router.push({path:'/singerInfo',query:{singerid:singerid}})
            }
        }
    }
</script>

<style scoped>
    :hover.activeClass{
        color: #2d8cf0;
        cursor: pointer;
    }
</style>