#include<cstdio>
#include<algorithm>
#include<queue>
#include<map>
#include<vector>
using namespace std;
const int N=1e3+10;
struct Node
{
	pair<int,int> p;
	int step;
	Node* ptr;
	Node(int step=-1)
	{
		this->step=step;
	}
}node[N][N];
int n,m,d;
int gcd(int a,int b)
{
	if(b==0)
		return a;
	return gcd(b,a%b);
}
pair<int,int> opt1(pair<int,int> bot)
{
	bot.first=0;
	return bot;
}
pair<int,int> opt2(pair<int,int> bot)
{
	bot.second=0;
	return bot;
}
pair<int,int> opt3(pair<int,int> bot)
{
	bot.first=m;
	return bot;
}
pair<int,int> opt4(pair<int,int> bot)
{
	bot.second=n;
	return bot;
}
pair<int,int> opt5(pair<int,int> bot)
{
	int tot=bot.first+bot.second;
	if(tot<=n)
	{
		bot.second=tot;
		tot=0;
	}
	else
	{
		bot.second=n;
		tot-=n;
	}
	bot.first=tot;
	return bot;
}
pair<int,int> opt6(pair<int,int> bot)
{	
	int tot=bot.first+bot.second;
	if(tot<=m)
	{
		bot.first=tot;
		tot=0;
	}
	else
	{
		bot.first=m;
		tot-=m;
	}
	bot.second=tot;
	return bot;
}
void init()
{
	for(int i=0;i<N;i++)
	{
		for(int j=0;j<N;j++)
		{
			node[i][j].p.first=i;
			node[i][j].p.second=j;
		}
	}
	return ;
}
vector<pair<int,int> > sol;
int calc()
{
	queue<pair<int,int> >qe;
	qe.push(pair<int,int>(0,0));
	pair<int,int> (*func_ptr[])(pair<int,int>)={&opt1,&opt2,&opt3,&opt4,&opt5,&opt6};
	node[0][0].step=0;
	int ans=0;
	while(!qe.empty())
	{
		pair<int,int> x=qe.front();
		qe.pop();
		if(x.first==d||x.second==d)
		{
			sol.push_back(x);
			ans++;
			continue;
		}
		for(int i=0;i<6;i++)
		{
			pair<int,int> pt=func_ptr[i](x);
			if(node[pt.first][pt.second].step==-1)
			{
				node[pt.first][pt.second].step=node[x.first][x.second].step+1;
				node[pt.first][pt.second].ptr=&node[x.first][x.second];
				qe.push(pt);
			}
		}
	}
	return ans;
}
void print(pair<int,int> x)
{
	if(!(x.first==0&&x.second==0))
	{
		print(node[x.first][x.second].ptr->p);
		printf("->");
	}
	printf("(%d,%d)",x.first,x.second);
	return ;
}
void print_solution(int ans)
{
	printf("Total solution:%d\n",ans);
	for(int i=0;i<sol.size();i++)
	{
		printf("Soluton %d:\n",i+1);
		printf("Total steps:%d\n",node[sol[i].first][sol[i].second].step);
		print(sol[i]);
		printf("\n");
	}
	return ;
}
int main()
{
	init();
	scanf("%d%d%d",&m,&n,&d);
	if(d%gcd(m,n)!=0||d>n)
	{
		printf("No solution!");
		return 0;
	}
	int ans=calc();
	print_solution(ans);
	return 0;
}