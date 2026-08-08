#include<cstdio>
#include<algorithm>
#include<climits>
#include<ctime>
#include<cstring>
#include<cstdlib>
#include<iostream>
#include<fstream>
using namespace std;
const int N=1e5+10;
int a[N];
struct Tree
{
	int s[2];
	int fa,v,size;
	init(int fa=0,int v=0)
	{
		this->fa=fa;
		this->v=v;
	}
}tree[N];
int root,idx;
void pushup(int x)
{
	tree[x].size=tree[tree[x].s[0]].size+tree[tree[x].s[1]].size+1;
}
void rotate(int x)
{
	int y=tree[x].fa,z=tree[y].fa;
	int k=tree[y].s[1]==x;
	
	tree[z].s[tree[z].s[1]==y]=x;
	tree[x].fa=z;
	
	tree[y].s[k]=tree[x].s[k^1];
	tree[tree[x].s[k^1]].fa=y;
	
	tree[x].s[k^1]=y;
	tree[y].fa=x;
	
	pushup(y);
	pushup(x);
	return ;
}
void splay(int x,int k)
{
	while(tree[x].fa!=k)
	{
		int y=tree[x].fa,z=tree[y].fa;
		if(z!=k)
		{
			if((tree[y].s[1]==x)^(tree[z].s[1]==y))
			{
				rotate(x);
			}
			else
			{
				rotate(y);
			}
		}
		rotate(x);
	}
	if(!k)
		root=x;
}
int get_k(int k)
{
	int x=root;
	while(x)
	{
		if(tree[tree[x].s[0]].size>=k)
			x=tree[x].s[0];
		else if(tree[tree[x].s[0]].size+1>=k)
			return x;
		else
		{
			k-=tree[tree[x].s[0]].size+1;
			x=tree[x].s[1];
		}
	}
	return -1;
}
void m_insert(int v)
{
	int u=root;
	int p=0;
	while(u)
	{
		p=u;
		u=tree[u].s[tree[u].v<v];
	}
	u=++idx;
	tree[u].init(p,v);
	tree[u].size=1;
	if(p)
		tree[p].s[tree[p].v<v]=u;
	splay(u,0);
	return ;
}
int cnt;
int n;
int sp[N];
int m;
bool vis[N];
int get()
{
	int k=rand()%n+1;
	n--;
	int l=get_k(k);
	int r=get_k(k+2);
	splay(l,0);
	splay(r,l);
	++cnt;
	int p=tree[tree[r].s[0]].v;
	vis[tree[tree[r].s[0]].v]=true;
	a[tree[tree[r].s[0]].v]++;
	tree[r].s[0]=0;
	pushup(r);
	pushup(l);
	return p;
} 
char s[N];
ifstream Read;
void restart()
{
	memset(a,0,sizeof(a));
	memset(s,0,sizeof(s));
	memset(vis,0,sizeof(vis));
	memset(sp,0,sizeof(sp));
	root=idx=0;
	Read>>s;
	ifstream din;
	din.open(s);
	din>>n;
	m=n;
	for(int i=1;i<=n;i++)
		din>>sp[i];
	for(int i=0;i<=n+1;i++)
	{
		m_insert(i);
	}
	return ;
}
void dealt()
{
	Read>>s;
	ofstream dout;
	dout.open(s);
	int num;
	Read>>num;
	for(int i=1;i<=num;i++)
	{
		int p=get();
		dout<<cnt<<':'<<sp[p]<<endl;
	}
	return ;
}
void restore()
{
	Read>>s;
	ofstream dout;
	dout.open(s);
	dout<<n<<endl;
	for(int i=1;i<=m;i++)
	{
		if(!vis[i])
			dout<<sp[i]<<endl;
	}
	return ;
}
int main()
{
	srand(time(0));
	Read.open("operate.txt");
	int opt;
	while(Read>>opt)
	{
		switch(opt)
		{
			case 1:restart();break;
			case 2:dealt();break;
			case 3:restore();break;
		}
	}
	return 0;
} 
