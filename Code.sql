# 1. Rewarding Most Loyal Users: Find the 5 oldest users of the Instagram from the database provided
 select * from users
 order by created_at
 limit 5;
 
# 2. Remind Inactive Users to Start Posting: Find the users who have never posted a single photo on Instagram
select * from users
left join photos 
on users.id = photos.user_id
where photos.id is null;

#3. Declaring Contest Winner: Identify the winner of the contest and provide their details to the team
SELECT username,photos.id,photos.image_url,
	   count(*) as total
FROM photos
INNER JOIN likes 
    ON likes.photo_id = photos.id
INNER JOIN users 
    ON photos.user_id = users.id
GROUP BY photos.id 
ORDER BY total desc
LIMIT 1;

#4. Hashtag Researching: Identify and suggest the top 5 most commonly used hashtags on the platform
SELECT tags.tag_name,
       count(*) as total
FROM photo_tags
     JOIN tags 
       ON photos_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total desc
LIMIT 5;

#5. Launch AD Campaign: What day of the week do most users register on? Provide insights on when to schedule an ad campaign
Select  
    dayname(created_at) as day,
    count(*) as total
from users
group by day
order by total desc
limit 7;

#6. User Engagement: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users
select(select count(*)
       from photos)/(select count(*) 
                     from users) as avg;
    
#7. Bots & Fake Accounts: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).
select username, count(*) as num_likes
from users
Inner join likes on users.id = likes.user_id
group by likes.user_id
having num_likes = (select count (*) from photos);
