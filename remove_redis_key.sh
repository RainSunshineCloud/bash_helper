CREATE TABLE `user_play_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `vedio_id` bigint(20) NOT NULL COMMENT '视频合集ID',
  `vedio_set_id` bigint(20) NOT NULL COMMENT '视频子集ID',
  `vedio_type` tinyint(20) NOT NULL COMMENT '视频类型：1-微剧、2-正片、3-点播、4-VIP',
  `watch_progress` int(11) NOT NULL COMMENT '观看进度，单位秒',
  `watch_percent` int(11) NOT NULL COMMENT '观看百分比',
  `ctime` DATETIME NOT NULL COMMENT '创建时间',
  `mtime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `nk` (`user_id`,`update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户观影历史';