<template>
    <div>
        <a-card>
            <p style="font-size: 22px;text-align: center">{{review.username}}的歌手申请</p>
            <img style="margin-left: 15%" height="300px" width="640px" :src="review.img" :alt="review.username">
            <div style="font-size: 18px;margin-top: 20px;margin-left: 3%">{{review.username}}的音乐作品:</div>
            <audio controls="controls" style="margin-left: 4%;width: 900px;height: 30px;margin-top: 20px">
                <source :src="review.music">
                Your browser does not support the audio element.
            </audio>
            <a-card style="margin:20px 20px">
            <div style="font-size: 18px;">{{review.username}}想成为歌手的原因:</div>
            <div style="margin-top: 5px">{{review.reason}}</div>
            <div style="font-size: 18px;margin-top: 20px">{{review.username}}的个人简介:</div>
            <div style="margin-top: 5px">{{review.details}}</div>
            </a-card>
            <a-tooltip placement="bottom">
                <template slot="title">
                    <span>通过审核</span>
                </template>
                <a-button v-show="review.result==='0'" shape="circle" type="primary"  @click="reviewSuccess" icon="check" style="margin-left: 40%;margin-top: 20px"></a-button>
            </a-tooltip>

            <a-tooltip placement="bottom">
                <template slot="title">
                    <span>未通过审核</span>
                </template>
                <a-button v-show="review.result==='0'" shape="circle" type="danger"  @click="reviewFail" icon="close" style="margin-left: 5%"></a-button>
            </a-tooltip>
            <a-tag style="margin-left: 40%;margin-top: 30px" color="green" v-show="review.result==='1'">审核成功</a-tag>
            <a-tag style="margin-left: 40%;margin-top: 30px" color="volcano" v-show="review.result==='-1'">审核失败</a-tag>
        </a-card>
    </div>
</template>

<script>
    export default {
        name: "AdminReview",
        mounted(){
            this.review=JSON.parse(this.$route.query.review);
        },
        data(){
            return{
                review:{},
                submitModal:false,
                // 精确度小，可允许的误差范围小；为1时，则表示滑块要与凹槽完全重叠，才能验证成功。默认值为5
                accuracy: 7,
                imgs:["http://q7u9zowxe.bkt.clouddn.com/midouzi.jpg",],
                reviewResult:''
            }
        },
        methods:{
            reviewSuccess(){
              this.axios.get('/user/reviewSuccess?userid='+this.review.userid)
                  .then(res=>{
                    this.$router.push('/adminPage');
                    this.$message.success('操作成功！');
                  }).catch(err=>{
                console.log(err);
              })
            },
            reviewFail(){
              this.axios.get('/user/reviewFail?userid='+this.review.userid)
                  .then(res=>{
                    this.$message.success('操作成功！');
                    this.$router.push('/adminPage');
                  }).catch(err=>{
                console.log(err);
              })
            },
            onAgain() {
                this.$message.warning("检测到非人为操作");
                this.$refs.slideblock.reset();
            },
        }
    }
</script>

<style scoped>

</style>
