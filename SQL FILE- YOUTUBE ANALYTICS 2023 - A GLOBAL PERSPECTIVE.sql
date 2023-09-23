create database youtube;

use youtube;
show tables;

select * from youtube2023;

-- YouTube Analytics:

#1.	What are the top 10 YouTube channels based on subscribers?

SELECT YouTube_channel_name,subscribers
FROM youtube2023 ORDER BY subscribers DESC
LIMIT 10;
 
#2.	How do channels with the highest video views differ in terms of category, country, and channel type?

SELECT Category,Country, channel_type,
    sum(video_views) AS Total_video_views
FROM youtube2023
GROUP BY Category, Country, channel_type
ORDER BY Total_video_views Desc;

-- Content Strategy:

#1.	Which content categories have the highest video views and subscribers on average in 2023?

SELECT category, round(AVG(subscribers)) 'avg_subscribers', round(AVG(video_views)) 'AVG_video_views'
FROM youtube2023
GROUP BY category
ORDER BY AVG(video_views) DESC;

#2.	Top 20 common content categories in different countries?

SELECT Country, category, COUNT(category) AS channel_count
FROM youtube2023
GROUP BY Country, category
ORDER BY COUNT(category) DESC limit 20;

#3.	How many YouTube channels have over one hundred million subscribers?

select YouTube_channel_name, subscribers from youtube2023 where subscribers > 100000000;

-- Regional Influencers:

#1.	How do influencers from different countries compare in terms of their global ranking based on subscribers and video views?

SELECT Country, Youtuber, subscribers_rank, video_views_rank
FROM (
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY Country ORDER BY subscribers DESC) AS subscribers_rank,
           DENSE_RANK() OVER (PARTITION BY Country ORDER BY video_views DESC) AS video_views_rank
    FROM youtube2023
) ranked_data;

-- Geospatial Visualization:

#1.	Count the total channels of each country with their average subscribers and video views

SELECT Country, COUNT(*) AS channel_count, round(AVG(subscribers)) AS avg_subscribers, round(AVG(video_views)) AS avg_video_views
FROM youtube2023
GROUP BY Country order by count(*) desc; 

-- Trending Topics:

#1.	Top 3 content categories have experienced the highest growth in video views over the last 30 days?

SELECT category, SUM(video_views_for_the_last_30_days) AS total_views_growth
FROM youtube2023
GROUP BY category
ORDER BY total_views_growth DESC limit 3;









