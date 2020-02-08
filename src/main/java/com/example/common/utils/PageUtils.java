package com.example.common.utils;

import com.baomidou.mybatisplus.plugins.Page;
import lombok.Data;

import java.io.Serializable;
import java.util.List;
@Data
public class PageUtils implements Serializable {
    private static final long serialVersionUID = 1L;
    //总记录数
    private int totalCount;
    //每页记录数
    private int pageSize;
    //总页数
    private int totalPage;
    //当前页数
    private int currPage;
    //列表数据
    private List<?> list;

    //前一页
    private int prePage;
    //下一页
    private int nextPage;

    //是否为第一页
    private boolean isFirstPage = false;
    //是否为最后一页
    private boolean isLastPage = false;
    //是否有前一页
    private boolean hasPreviousPage = false;
    //是否有下一页
    private boolean hasNextPage = false;
    //导航页码数
    private int navigatePages;
    //所有导航页号
    private int[] navigatePageNums;
    //导航条上的第一页
    private int navigateFirstPage;
    //导航条上的最后一页
    private int navigateLastPage;

    /**
     * 分页
     * @param list        列表数据
     * @param totalCount  总记录数
     * @param pageSize    每页记录数
     * @param currPage    当前页数
     */
    public PageUtils(List<?> list, int totalCount, int pageSize, int currPage,int navigatePages) {
        this.list = list;
        this.totalCount = totalCount;
        this.pageSize = pageSize;
        this.currPage = currPage;
        this.totalPage = (int)Math.ceil((double)totalCount/pageSize);
        this.navigatePages = navigatePages;
        //计算导航页
        calcNavigatePageNums();
        //计算前后页，第一页，最后一页
        calcPage();
        //判断页面边界
        judgePageBoudary();
    }

    /**
     * 分页
     */
    public PageUtils(Page<?> page,int navigatePages) {
        this.list = page.getRecords();
        this.totalCount = (int)page.getTotal();
        this.pageSize = page.getSize();
        this.currPage = page.getCurrent();
        this.totalPage = (int)page.getPages();
        this.navigatePages = navigatePages;
        //计算导航页
        calcNavigatePageNums();
        //计算前后页，第一页，最后一页
        calcPage();
        //判断页面边界
        judgePageBoudary();
    }

    /**
     * 计算导航页
     */
    private void calcNavigatePageNums() {
        //当总页数小于或等于导航页码数时
        if (this.totalPage <= this.navigatePages) {
            this.navigatePageNums = new int[this.totalPage];
            for (int i = 0; i < this.totalPage; i++) {
                this.navigatePageNums[i] = i + 1;
            }
        } else { //当总页数大于导航页码数时
            this.navigatePageNums = new int[this.navigatePages];
            int startNum = this.currPage - this.navigatePages / 2;
            int endNum = this.currPage + this.navigatePages / 2;

            if (startNum < 1) {
                startNum = 1;
                //(最前navigatePages页
                for (int i = 0; i < this.navigatePages; i++) {
                    this.navigatePageNums[i] = startNum++;
                }
            } else if (endNum > this.totalPage) {
                endNum = this.totalPage;
                //最后navigatePages页
                for (int i = this.navigatePages - 1; i >= 0; i--) {
                    this.navigatePageNums[i] = endNum--;
                }
            } else {
                //所有中间页
                for (int i = 0; i < this.navigatePages; i++) {
                    this.navigatePageNums[i] = startNum++;
                }
            }
        }
    }

    /**
     * 计算前后页，第一页，最后一页
     */
    private void calcPage() {
        if (this.navigatePageNums != null && this.navigatePageNums.length > 0) {
            this.navigateFirstPage = this.navigatePageNums[0];
            this.navigateLastPage = this.navigatePageNums[this.navigatePageNums.length - 1];
            if(this.currPage == 1){
                this.prePage = 1;
            }
            if (this.currPage > 1) {
                this.prePage = this.currPage - 1;
            }
            if (this.currPage < this.totalPage) {
                this.nextPage = this.currPage + 1;
            }
            if(this.currPage == this.totalPage) {
                this.nextPage = this.totalPage;
            }
        }
    }

    /**
     * 判定页面边界
     */
    private void judgePageBoudary() {
        this.isFirstPage = this.currPage == 1;
        this.isLastPage = this.currPage == this.totalPage || this.totalPage == 0;
        this.hasPreviousPage = this.currPage > 1;
        this.hasNextPage = this.currPage < this.totalPage;
    }



}
