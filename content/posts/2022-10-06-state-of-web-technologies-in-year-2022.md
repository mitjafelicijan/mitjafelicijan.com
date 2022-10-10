---
title: State of Web Technologies and Web development in year 2022
url: state-of-web-technologies-and-web-development-in-year-2022.html
date: 2022-10-06
draft: false
---

**Table of Contents**
1. [Initial thoughts](#initial-thoughts)
2. [Giving React JS a spin](#giving-react-js-a-spin)
3. [Bundlers and Transpilers](#bundlers-and-transpilers)
4. [Jam Stack, Mach Stack no snack](#jam-stack-mach-stack-no-snack)
5. [Tailwind CSS still rocks!](#tailwind-css-still-rocks)
6. [Code maintainability](#code-maintainability)
7. [Web development has a marketing issue](#web-development-has-a-marketing-issue)
8. [Conclusion](#conclusion)

## Initial thoughts

*This post is a critique on the current state of web development. It is an opinionated post! I will learn more about this in the future, and probably slightly change my mind about some of the things I criticize.*

I have started working on a hobby project about two weeks ago, and I wanted to use that situation as a learning one. Trying new things, new technologies, new tools. I always considered myself to be an adventurous person when it comes to technology. I never shy away from trying new languages, new operating systems etc. Likewise, I find the whole experience satisfying, and it tickles that part of my brain that finds discovery the highest of the mountains to climb.

What I always wanted to make was a coding game, that you would play in a browser (just to eliminate building binaries for each operating system) where you would level up your character and go into these scriptable battles. You know, RPG elements.

So, the natural way to go would be some sort of SPA (single page application) with basic routing and some state management. Nothing crazy.

> **Before we move on**, I have to be transparent. Take my views on this with a grain of salt. I have only scratched the surface with these technologies, and my knowledge is full of gaps. This is my experience using some of these products for the first time or in a limited capacity.
>

Having this out of the way, I got myself a fresh pot of coffee and down the rabbit hole I went.

## Giving React JS a spin

I first tried [React JS](https://reactjs.org/). I kind of like it. Furthermore, I have worked with libraries like this in the past and also wrote a couple of them (nothing compared to that level), but I had the basic understanding of what was going on. I rolled up a project quickly and had basic things done in a matter of two hours, which was impressive.

I prefer using [Tailwind CSS](https://tailwindcss.com/) for my styling pleasures, and integrating that was also a painless experience. It was actually nice to see that some things got better with time. In about 2 minutes I got Tailwind working, and I was able to use classes at my disposal. All that `postcss` stuff was taken care of by adding a couple of things in config files (all described really well in their documentation).

It is not that different from Vue which I have had more encounters with in the past People will probably call me a lunatic for saying this. But you know, it is the truth. Same same, but different. I still believe that using libraries like this is beneficial. I am not a JavaScript purist. They all have their quirks, but at the end of the day, I truly believe it’s worth it.

## Bundlers and Transpilers

I still reject calling [Typescript](https://www.typescriptlang.org/) to [JavaScript](https://www.javascript.com/) conversion a "compilation process". I call them [transpilers](https://devopedia.org/transpiler), and I don’t care! 😈

And if you want to fight this, take a look at this little chart and be mad at it!

![Compiling vs Transpiling](/assets/state-of-web/compiling-vs-transpiling.png)

The first one that I ever used was [webpack](https://webpack.js.org/), and it was an absolute horrific experience. Saying this, it is an absolutely fantastic tool. I felt more like a config editor than actually a programmer. To be fair, I am a huge fan of [make](https://www.gnu.org/software/make/), and you can do as you wish with this information. I like my build systems simple.

Also, isn’t it interesting that we need something like [Babel](https://babeljs.io/) to make JavaScript code work in a browser that has only one client side scripting available, which is by no accident also JavaScript. Why? I know why it’s needed, but seriously, why.

I haven’t used Babel for years now. Or if I did, it was packaged together by some other bundler thingy. Which does not make things better, but at least I didn’t need to worry about it.

I really don’t like complicated build systems. I really don’t like abstracting code and making things appear magical. The older I get, the more I appreciate clear and clean, expressive code. No one-liners, if possible.

But I have to give props to [Vite](https://vitejs.dev/)! This was one of the best developer experiences I have ever had. Granted, it still has magical properties. And yes, it still is a bundler and abstracts things to the nth degree. But at least it didn’t force me to configure 700 lines of JSON. And I know that this makes me a hypocrite. You can’t have it all. Nonetheless, my reasoning here is, if using bundlers is inevitable, then at least they should provide an excellent developer experience.

I also noticed that now the catch-all phrase is “blazingly fast” and  “lightning fast” and “next generation” and stuff like that. I mean, yeah, tools should get faster with time. But saying that starting a project now takes 2 seconds instead of 20 seconds is something that is a break it or make it kind of a deal is ridiculous. I don’t mind waiting a couple of seconds every couple of days. I also don’t create 700 projects every day, and also who does? This argument has no bite. All I want is a decent reload time (~100ms is more than good enough for me) and that is it.

You don’t need to sell me benefits if I only get them when I start a fresh project, and then try to convince me that this is somehow changing the fate of the universe. First of all, it is not. And second, if this is your only argument for your tool, I would advise you to maybe re-focus your efforts to something else. Vite says that startup times are really fast. And if that would be the only thing differentiating it from other tools, I would ignore it. But it has some really compelling features like [Hot Module Replacement](https://www.geeksforgeeks.org/reactjs-hot-module-replacement/) that really works well. It was a joy to use.

So, I will be definitely using Vite in the future.

## Jam Stack, Mach Stack no snack

Let's get a couple of the acronyms out of the way, so we all know what we are talking about:

- Jam Stack - JavaScript, API and Markup
- Mach Stack - Microservices, API-first, Cloud-Native SaaS, Headless

It is so hard to follow all these new trendy things happening around you, that it makes you have a massive **FOMO** all the time. But on the other hand, you also don’t want to be that old fart that doesn’t move with the times and still writes his trusty jQuery code while listening to Blink 182 All the small things on full blast. It’s a good song, don’t get me wrong, but there are other songs out there.

I have to admit. [Vercel](https://vercel.com/) is really cool! Love the simplicity of the service. You could compare it to [Netlify](https://www.netlify.com/). I haven’t tried Netlify extensively, but from a couple of experimental deployments I still prefer Vercel. It is much more streamlined, but maybe this is bias in me. I really like Vercel’s Analytics, which give you a [Core Web Vitals report](https://web.dev/vitals/) in their admin console. Kind of cool, I’m not going to lie.

This whole idea about frontend and backend merging into [SSR (server-side rendering)](https://www.debugbear.com/blog/server-side-rendering) looks so good on paper. It almost doesn’t come with any major flaws.

But when it comes to the actual implementation, there is much to be desired. I’m going to lump [Next.js](https://nextjs.org/) and [Nuxt.js](https://nuxtjs.org/) together because they are essentially the same thing, just a different library.

Now comes the reality. Mixing backend and frontend in this manner creates this weird mental model where you kind of rely on magical properties of these libraries. You relinquish control over to them for better developer experience. But is that really true? Initially, I was so stoked about it. However, the more I used them, the more I felt uncomfortable. I felt dirty, actually. Maybe this is because I come from old ways of doing things where you control every step of request, and allowing something to hijack it feels like blasphemy.

More than that, some pretty significant technical issues arose from this. How do you do JWT token authentication? You put it in `api` folder and then do some fetching and storing into local state management. But doing this also requires some tinkering with await/async stuff on the React/Vue side of things. And then you need to write middleware for it. And the more I look at it, the more I see that this whole thing was not meant to be used like this, and it all feels and looks like a huge hack.

The issue I have with this is that they over-promise and under-deliver. They want to be an all-in-one replacement for everything, and they don’t deliver on this promise. And how could they?! We have to be fair. It is an impossible task.

They sell you [NoOps](https://www.geeksforgeeks.org/overview-of-noops/), but when you need to accomplish something a little bit more out of the scope of Hello World, you have to make hacky decisions to make it work. And having a deployment strategy that relies on many moving parts is never a good idea. Abstracting too much is usually a sign of bad architecture.

Lately, this has become a huge trend that will for sure bite us in the future. And let’s not get it twisted. By doing this, PaaS providers like [AWS](https://aws.amazon.com/), [GCS](https://cloud.google.com/), etc. obscure their billing, and you end up paying more than you really should. And even if that is not an issue, it comes down to the principle of things. AWS is known for having multiple “currencies“ inside their projects like write operations, read operations, etc. which add up, and it creates this impossible to track billing scheme. It all behaves suspiciously like a pay-to-win game you could find on mobile phones that scams you out of your money.

And as far as I am concerned, the most important thing was me not coding the functionalities for the game I want to make. I was battling libraries and cloud providers. How to deploy, what settings are relevant. Bad documentation or multiple versions of achieving the same thing. You are getting bombarded by all this information, and you don’t really have any control over it. Production-ready code becomes a joke, essentially. Especially if you tend to work on that project for a prolonged period of time.

All of these options end up creating a fatigue. What to choose, what not to choose. Unnecessary worrying about if the stack will still be deemed worthy in six months. There is elegance in simplicity.

> JavaScript UI frameworks and libraries work in cycles. Every six months or so, a new one pops up, claiming that it has revolutionized UI development. Thousands of developers adopt it into their new projects, blog posts are written, Stack Overflow questions are asked and answered, and then a newer (and even more revolutionary) framework pops up to usurp the throne. — Ian Allen

![To many options](/assets/state-of-web/2008-vs-2020.png)

And this jab at these libraries and cloud providers is not done out of malice. It is a real concern that I have about them. In my life, I have seen technologies come and go, but the basics always stick around. So surrendering all the power you have to a library or a cloud provider is in my opinion a stupid move.

## Tailwind CSS still rocks!

You know, many people say negative things about Tailwind. And after a lot of deliberation, I came to the conclusion that Tailwind is good for two types of developers. Tailwind is good for a complete noob or a senior developer. A complete noob doesn’t really care about inner workings of CSS, and a senior developer also doesn’t care about CSS. Well, at least, not anymore. And developers in between usually have the biggest issues with it. Not always of course, but in a lot of cases.

I like the creature comforts of Tailwind. Being utility first would make me argue that it is actually more similar to [Sass](https://sass-lang.com/) or [Less](https://lesscss.org/) than something like Bootstrap. Not technically, but ideologically. After I started using it, I never looked back. I use it every time I need to do something web related.

Writing CSS for general things feels like going several steps back. Instead of focusing on what you are actually trying to achieve, you focus on notations like [BEM](https://en.bem.info/methodology/css/), code structuring, optimizing HTML size. Just doing things that make 0.1% difference. You know that saying: Early optimization is the root of all evil. Exactly that.

I am also not saying that Tailwind is the cure for everything. Sometimes custom CSS is necessary. But from what I found out in using it for almost two years in a production environment (on a site getting quite a lot of traffic and constantly being changed), I can say without any reservations that Tailwind saved our asses countless times. We would be rewriting CSS all the time without it. And I don’t really think writing CSS is the best way to spend my time.

I have also noticed that people who criticize Tailwind the most never actually used it in a real project that has a long lifetime with plenty of changes that will happen in the future.

But you know, whatever floats your boat!

## Code maintainability

Somehow, people also stopped talking about maintenance. If you constantly try to catch the latest and greatest train, you are by that logic always trying new things. Which is a good thing if you want to learn about technologies and try them. But for the production environment, you have to have a stable stack that doesn’t change every 6 months.

You can lock dependencies for sure. Nevertheless, the hype train moves along anyway. And the mindset this breeds goes against locking the code. This bleeding-edge rolling release cycle is not helping. That is why enterprise solutions usually look down on these popular stacks and only do bare minimum to appear hip and cool.

With that said, I still think that progress is good, but should be taken with a grain of salt. If your project is something that should be built once and then rarely updated, going with the latest stack is a possible way to go. But, if you are working on a project that lasts for years, you should probably approach it with some level of caution. Web development is often times too volatile.

## Web development has a marketing issue

I noticed that almost every project now has this marketing spin put on it. Everything is blazingly fast now. I get it, they are competing for your attention, but what happened to just being truthful and not inflating reality.

And in order to appeal to mass market, they leave things out of their marketing materials. These open-source projects are now behaving more and more like companies do. Which is a scary thought on its self.

And we are also seeing a rise in a concept of building a company in the open, which is a good thing, don't get me wrong. But when it is using open-source to lure people and then lock them in their ecosystem, there is where I have issues with it.

This might be because I have been using GNU/Linux for 20 years now and have been so beholden for my success to open-source that I see issues when open-source is being used to trick people into a false sense of security that these projects are built in the spirit of open-source. Because there is a difference. They are NOT! They have a really specific goal in mind. And the open-source is being used as a delivery system. Which is in my opinion disgusting!

## Conclusion

I will end my post with this. Web development is running now in circles. People are discovering [RPC](https://www.tutorialspoint.com/remote-procedure-call-rpc) now and this is the now the next big thing. [GraphQL](https://graphql.org/) is so passé. And I am so tired of it all. Of blazingly fast libraries, of all these new technologies that are actually just a remake of old ones. Of just the general spirit of the web. I will just use what I already know. Which worked 10 years ago and will work 10 years after this. I will adopt a couple of little tools like Vite. But I will not waste my time on this anymore.

It was a good exercise to get in touch with what’s new now. Nothing really changed that much. FOMO is now cured! Now I have to get my ass back to actually code and make the project that I wanted to make in the first place.
