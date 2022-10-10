---
title: Sentiment distribution analysis based on political bias in online publications
url: sentiment-based-on-political-bias.html
date: 2022-06-28
draft: true
---

I have been wondering for a long time what would sentiment differences look based on political leaning from popular publications. Is it the left that is more optimistic, center or the right.

> Before people loose their minds, I don't care about political stuff and this is data we are talking about and not my personal feelings about it. So, before saying anything have this in mind and let data speak for itself.

## Preparing the data

The first step in getting stories from publications so we can start doing sentiment analysis on it. I have chosen to select 30 publications. 10 from left leaning publications, 10 from centre and 10 from right leaning ones.

To find out leaning of a publication I will defer to AllSides website which provide a [Media Bias Ratings](https://www.allsides.com/media-bias/ratings).

![AllSides Bias Chart](https://www.allsides.com/sites/default/files/AllSidesMediaBiasChart-Version6_0.jpg)

The chart above is taken from AllSides and demonstrates political leaning of publications. This data changes over time and AllSides have made the revisions publicly available on their website.

- [Learn more about Version 6](https://www.allsides.com/blog/new-allsides-media-bias-chart-version-6-updated-ratings-npr-newsmax-and-more)
- [Learn more about Version 5](https://www.allsides.com/blog/new-allsides-media-bias-chart-version-42)
- [Learn about Version 4](https://www.allsides.com/blog/new-allsides-media-bias-chart-announcing-version-4)
- [Learn about Version 3](https://www.allsides.com/blog/new-allsides-media-bias-chart-version-3)
- [Learn about Version 2](https://www.allsides.com/blog/new-allsides-media-bias-chart-version-2-updated-media-bias-ratings)
- [Learn about Version 1.1](https://www.allsides.com/blog/updated-allsides-media-bias-chart-version-11)
- [Learn about Version 1](https://www.allsides.com/blog/introducing-allsides-media-bias-chart)


They categorise political bias AllSides came up with is:

TODO: CREATE A HORIZONTAL ARRAY STYLE OF CHART IMAGE

- Left,
- Lean Left,
- Center,
- Lean Right,
- Right.

I will group Left and Lean Left together. And the same goes for Lean Right and Right. So we end up with three groups [Left, Center, Right].

The list I have ended up with contains these publications:

- Left political bias:
	- BuzzFeed News (https://www.buzzfeednews.com)
	- CNN (https://cnn.com)
	- Daily Beast (https://www.thedailybeast.com)
	- HuffPost (https://www.huffpost.com)
	- The Intercept (https://theintercept.com)
	- Vox (https://www.vox.com)
	- Slate (https://slate.com)
	- The New Yorker (https://www.newyorker.com)
	- MSNBC (https://www.msnbc.com)
	- New York Times News (https://www.nytimes.com)
- Center political "bias":
	- Axios (https://www.axios.com)
	- BBC (https://www.bbc.com)
	- News Week (https://www.newsweek.com)
	- Reuters (https://www.reuters.com)
	- RealClear Politics (https://www.realclearpolitics.com)
	- The Hill (https://thehill.com)
	- The Wall Street Journal News(https://www.wsj.com)
	- Associated Press News (https://apnews.com)
	- CNET (https://www.cnet.com)
	- Forbes (https://www.forbes.com)
- Right political bias:
	- The American Spectator (https://spectator.org)
	- Breitbart News (http://www.breitbart.com)
	- The Blaze (https://www.theblaze.com)
	- Daily Caller (http://dailycaller.com)
	- Daily Mail (https://www.dailymail.co.uk)
	- The Daily Wire (https://www.dailywire.com)
	- Fox News (https://www.foxnews.com)
	- The Federalist (https://thefederalist.com)
	- New York Post Opinion (https://nypost.com/opinion/)
	- OANN (https://www.oann.com)







