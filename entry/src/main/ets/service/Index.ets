import api from '../api/index';
import httpRequest from '../utils/HttpUtil';
import * as types from '../interface/Index'
import { SocialEnum } from '../common/enum';
import { MusicInterface,DeviceInterface,MyAwesomeData,CommentInterface } from '../interface/Index';
import { DEVICE_INFO } from '../common/constant';
import CryptoJS from '@ohos/crypto-js';
/**
 * @description: 登录
 * @date: 2024-01-15 21:32
 * @author wuwenqiang
 */
export const loginService = (userAccount:string,password:string):Promise<MyAwesomeData<types.UserDataInterface>>=>{
  password = CryptoJS.MD5(password).toString();// 使用md5加密
  return httpRequest.post<types.UserDataInterface>(api.login,{userAccount,password})
};

/**
 * @description: 根据token获取用户信息
 * @date: 2023-12-1 23:39
 * @author wuwenqiang
 */
export const getUserDataService = (token:string):Promise<MyAwesomeData<types.UserDataInterface>>=> {
  httpRequest.setToken(token);
  return httpRequest.get<types.UserDataInterface>(api.getUserData);
}

/**
 * @description: 注册
 * @date: 2024-01-21 14:48
 * @author wuwenqiang
 */
export const registerService = (userData:types.UserDataInterface):Promise<MyAwesomeData<types.UserDataInterface>>=>{
  userData = {...userData};
  userData.password = CryptoJS.MD5(userData.password).toString();// 使用md5加密
  return httpRequest.post<types.UserDataInterface>(api.register,userData)
};

/**
 * @description: 注册
 * @date: 2024-01-21 14:48
 * @author wuwenqiang
 */
export const verifyUserService = (userAccount:string|undefined,email:string|undefined):Promise<MyAwesomeData<number>>=>{
  return httpRequest.post<number>(api.vertifyUser,{userAccount,email})
};

/**
 * @description: 找回密码
 * @date: 2025-01-19 22:59
 * @author wuwenqiang
 */
export const sendEmailVertifyCodeService = (email:string):Promise<MyAwesomeData<number>>=>{
  return httpRequest.post<number>(api.sendEmailVertifyCode,{email})
};

/**
 * @description: 邮箱验证码登录
 * @date: 2025-01-28 14:22
 * @author wuwenqiang
 */
export const loginByEmailService = (email:string,code:string):Promise<MyAwesomeData<types.UserDataInterface>>=>{
  return httpRequest.post<types.UserDataInterface>(api.loginByEmail,{email,code})
};

/**
 * @description: 修改用户信息
 * @date: 2024-01-10 23:01
 * @author wuwenqiang
 */
export const updateUserDataService = (userData:types.UserDataInterface):Promise<MyAwesomeData<number>>=>{
  return httpRequest.put<number>(api.updateUser,userData)
};

/**
 * @description: 重置密码
 * @date: 2025-01-26 22:21
 * @author wuwenqiang
 */
export const resetPasswordService = (email:string,password:string,code:string):Promise<MyAwesomeData<types.UserDataInterface>>=>{
  password = CryptoJS.MD5(password).toString();// 使用md5加密
  return httpRequest.post<types.UserDataInterface>(api.resetPassword,{email,password,code})
};

/**
 * @description: 更新密码
 * @date: 2025-01-28 14:22
 * @author wuwenqiang
 */
export const updatePasswordService = (oldPassword:string,newPassword:string):Promise<MyAwesomeData<number>>=>{
  oldPassword = CryptoJS.MD5(oldPassword).toString();// 使用md5加密
  newPassword = CryptoJS.MD5(newPassword).toString();// 使用md5加密
  return httpRequest.put<number>(api.updatePassword,{oldPassword,newPassword})
};

/**
 * @description: 获取推荐的音乐
 * @date: 2024-03-02 22:44
 * @author wuwenqiang
 */
export const getKeyWordMusicService = ():Promise<MyAwesomeData<types.MusicInterface>> => {
  return httpRequest.get<types.MusicInterface>(api.getKeywordMusic);
}

/**
 * @description: 获取模块分类
 * @date: 2024-03-02 22:44
 * @author wuwenqiang
 */
export const getMusicClassifyService = ():Promise<MyAwesomeData<Array<types.MusicClassifyInterface>>> => {
  return httpRequest.get<Array<types.MusicClassifyInterface>>(api.getMusicClassify);
}

/**
 * @description: 获取模块分类
 * @date: 2024-03-03 11:50
 * @author wuwenqiang
 */
export const getMusicListByClassifyIdService = (classifyId:number,pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<types.MusicInterface>>> => {
  return httpRequest.get<Array<types.MusicInterface>>(`${api.getMusicListByClassifyId}?classifyId=${classifyId}&pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 获取推荐的歌手
 * @date: 2024-03-03 18:23
 * @author wuwenqiang
 */
export const getMusicAuthorListByCategoryIdService = (categoryId:number,pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<types.MusicAuthorInterface>>> => {
  return httpRequest.get<Array<types.MusicAuthorInterface>>(`${api.getMusicAuthorListByCategoryId}?categoryId=${categoryId}&pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 获取音乐圈数据
 * @date: 2024-03-03 18:23
 * @author wuwenqiang
 */
export const getCircleListByTypeService = (type:string,pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<types.CircleInterface>>> => {
  return httpRequest.get<Array<types.CircleInterface>>(`${api.getCircleListByType}?type=${type}&pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 点赞
 * @date: 2024-03-12 23:25
 * @author wuwenqiang
 */
export const saveLikeService = (likeItem:types.LikeInterface):Promise<MyAwesomeData<types.LikeInterface>> => {
  return httpRequest.post<types.LikeInterface>(api.saveLike,likeItem);
}

/**
 * @description: 删除点赞
 * @date: 2024-03-12 23:25
 * @author wuwenqiang
 */
export const deleteLikeService = (relationId:number,type:SocialEnum):Promise<MyAwesomeData<number>> => {
  return httpRequest.delete<number>(`${api.deleteLike}?relationId=${relationId}&type=${type}`);
}

/**
 * @description: 添加评论
 * @date: 2024-03-12 23:25
 * @author wuwenqiang
 */
export const insertCommentService = (commentItem:types.CommentInterface):Promise<MyAwesomeData<types.CommentInterface>> => {
  return httpRequest.post<types.CommentInterface>(api.insertComment,commentItem);
}

/**
 * @description: 获取用户歌单
 * @date: 2024-03-16 23:25
 * @author wuwenqiang
 */
export const getMusicPlayMenuService = ():Promise<MyAwesomeData<Array<types.MuiscPlayMenuInterface>>> => {
  return httpRequest.get<Array<types.MuiscPlayMenuInterface>>(api.getMusicPlayMenu);
}

/**
 * @description: 获取我关注的歌手
 * @date: 2024-03-17 22:12
 * @author wuwenqiang
 */
export const getFavoriteAuthorService = (pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<types.MusicAuthorInterface>>> => {
  return httpRequest.get<Array<types.MusicAuthorInterface>>(`${api.getFavoriteAuthor}?pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 新增我关注的歌手
 * @date: 2024-08-27 21:43
 * @author wuwenqiang
 */
export const insertFavoriteAuthorService = (authorId:number):Promise<MyAwesomeData<number>> => {
  return httpRequest.post<number>(`${api.insertFavoriteAuthor}${authorId}`);
}

/**
 * @description: 新增我关注的歌手
 * @date: 2024-08-27 21:43
 * @author wuwenqiang
 */
export const deleteFavoriteAuthorService = (authorId:number):Promise<MyAwesomeData<number>> => {
  return httpRequest.delete<number>(`${api.deleteFavoriteAuthor}${authorId}`);
}

/**
 * @description: 获取播放记录
 * @date: 2024-03-17 22:12
 * @author wuwenqiang
 */
export const getMusicRecordService = (pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<types.MusicInterface>>> => {
  return httpRequest.get<Array<types.MusicInterface>>(`${api.getMusicRecord}?pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 插入播放记录
 * @date: 2024-03-17 22:12
 * @author wuwenqiang
 */
export const insertMusicRecordService = (musicId):Promise<MyAwesomeData<number>> => {
  const deviceInterface:DeviceInterface = AppStorage.Get<DeviceInterface>(DEVICE_INFO)
  return httpRequest.post<number>(api.insertMusicRecord,{musicId,...deviceInterface});
}

/**
 * @description: 添加收藏
 * @date: 2024-05-12 12:21
 * @author wuwenqiang
 */
export const insertMusicLikeService = (musicId:number):Promise<MyAwesomeData<number>> => {
  return httpRequest.post<number>(api.insertMusicLike + musicId,{});
}

/**
 * @description: 删除收藏
 * @date: 2024-05-12 12:21
 * @author wuwenqiang
 */
export const deleteMusicLikeService = (musicId:number):Promise<MyAwesomeData<number>> => {
  return httpRequest.delete<number>(api.deleteMusicLike + musicId);
}


/**
 * @description: 查询音乐是否已经收藏
 * @date: 2024-06-25 22:02
 * @author wuwenqiang
 */
export const isMusicFavoriteService = (musicId:number):Promise<MyAwesomeData<number>> => {
  return httpRequest.get<number>(api.isMusicFavorite + musicId);
}

/**
 * @description: 查询音乐是否已经收藏
 * @date: 2024-06-25 22:02
 * @author wuwenqiang
 */
export const getFavoriteDirectoryService = (musicId:number):Promise<MyAwesomeData<Array<types.FavoriteDirectoryInterface>>> => {
  return httpRequest.get<Array<types.FavoriteDirectoryInterface>>(`${api.getFavoriteDirectory}?musicId=${musicId}`);
}

/**
 * @description: 添加音乐收藏
 * @date: 2024-06-29 11:26
 * @author wuwenqiang
 */
export const insertMusicFavoriteService = (musicId:number,favoriteList:Array<types.FavoriteMusicInterface>):Promise<MyAwesomeData<number>> => {
  return httpRequest.post<number>(api.insertMusicFavorite+ musicId,favoriteList);
}

/**
 * @description: 创建音乐收藏夹
 * @date: 2024-06-29 11:26
 * @author wuwenqiang
 */
export const insertFavoriteDirectoryService = (favoriteDirectory:types.FavoriteDirectoryInterface):Promise<MyAwesomeData<types.FavoriteDirectoryInterface>> => {
  return httpRequest.post<types.FavoriteDirectoryInterface>(api.insertFavoriteDirectory,favoriteDirectory);
}

/**
 * @description: 音乐搜索
 * @date: 2024-07-06 09:01
 * @author wuwenqiang
 */
export const searchMusicService = (keyword:string,pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<MusicInterface>>> => {
  return httpRequest.get<Array<MusicInterface>>(`${api.searchMusic}?keyword=${keyword}&pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 插入一条说说
 * @date: 2024-07-08 23:05
 * @author wuwenqiang
 */
export const saveCircleService = (circle:types.CircleInterface):Promise<MyAwesomeData<number>> => {
  return httpRequest.post<number>(api.insertCircle,circle);
}

/**
 * @description: 根据收藏夹id查询音乐列表
 * @date: 2024-07-16 23:39
 * @author wuwenqiang
 */
export const getMusicListByFavoriteIdService = (favoriteId:number,pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<types.MusicInterface>>> => {
  return httpRequest.get<Array<types.MusicInterface>>(`${api.getMusicListByFavoriteId}?favoriteId=${favoriteId}&pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 获取歌手分类
 * @date: 2024-08-19 23:17
 * @author wuwenqiang
 */
export const getMusicAuthorCategoryService = ():Promise<MyAwesomeData<Array<types.MusicAuthorCategoryInterface>>> => {
  return httpRequest.get<Array<types.MusicAuthorCategoryInterface>>(api.getMusicAuthorCategory);
}

/**
 * @description: 根据歌手id获取歌曲列表
 * @date: 2024-08-29 21:45
 * @author wuwenqiang
 */
export const getMusicListByAuthorIdService = (authorId:number,pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<types.MusicInterface>>> => {
  return httpRequest.get<Array<types.MusicInterface>>(`${api.getMusicListByAuthorId}?authorId=${authorId}&pageNum=${pageNum}&pageSize=${pageSize}`);
}

/**
 * @description: 获取一级评论
 * @date: 2024-05-12 12:21
 * @author wuwenqiang
 */
export const getTopCommentListService = (relationId:number,type:string,pageNum:number,pageSize:number):Promise<MyAwesomeData<Array<CommentInterface>>> => {
  return httpRequest.get<Array<CommentInterface>>(`${api.getTopCommentList}?relationId=${relationId}&type=${type}&pageSize=${pageSize}&pageNum=${pageNum}`);
}

