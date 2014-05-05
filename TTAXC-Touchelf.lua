math.randomseed(os.time())

--configuration 
clickDelay=10
workDelay=240

tempColor=0
Colors={}
for i=1,7 do
    Colors[i]={}
    for j=1,7 do
        Colors[i][j]=0
    end
end

function click(x,y)
    touchDown(1,x,y)
    mSleep(math.random(20,50))
    touchUp(1,x,y)
end

function clickEx(x,y)
    x = math.random(x-20,x+20)
    y = math.random(y-20,y+20)
    touchDown(1,x,y)
    mSleep(clickDelay)
    touchUp(1,x,y)
end

function DumpColor()
    local s
    for i=1,7 do
        s=""
        for j=1,7 do
            s=s..Colors[i][j]..","
        end
    end
end

function hd2(i,j,m,n)
    clickEx(25+90*j,195+90*i)
    mSleep(clickDelay)
    clickEx(25+90*n,195+90*m)
end

function hd(i,j,m,n)
    touchDown(1,25+90*j,195+90*i)
	mSleep(50)
    touchMove(1,25+90*n,195+90*m)
	mSleep(50)
	touchUp(1,25+90*n,195+90*m)
end

function TestHeart()
    while true do
        if 0xed4247==getColor(257,163) or 0xc74245==getColor(257,170) then
            return
        else
            mSleep(500)
        end
    end
end

function TestStart()
    while true do
        if 0xc84145==getColor(336,836) and 0xfff4f6==getColor(336,837) then
            mSleep(500)
            click(400,836)
            return
        else
            mSleep(500)
        end
    end
end

function TestReady()
    while true do
        if (0x1f3116==getColor(587,965) and 0x21371b==getColor(588,965)) or (0x1e222b==getColor(69,870) and 0x252a35==getColor(68,870)) then
            return
        else
            mSleep(300)
        end
    end
end

function r(i,j)
    if i<1 or i>7 or j<1 or j>7 then
        tempColor = tempColor +1
        return tempColor
    else
        return Colors[i][j] 
    end
end

function CacheColor()
    local x=25
    local y=195
    keepScreen(true)
    for i=1,7 do
        y=y+90
        x=25
        for j=1,7 do
            x=x+90
            Colors[i][j]=getColor(x,y)
        end
    end
    keepScreen(false)
	--verify color
	mSleep(50)
	x=25
	y=195
	keepScreen(true)
	for i=1,7 do 
		y=y+90
		x=25
		for j=1,7 do
			x=x+90
			if (Colors[i][j]~=getColor(x,y)) then
				Colors[i][j]=r(8,8)
			end
		end
	end
	keepScreen(false)
end


function TestGrid(i,j)
    --5 start
    --up
    if r(i,j)==r(i-1,j-2) and r(i,j)==r(i-1,j-1) and r(i,j)==r(i-1,j+1) and r(i,j)==r(i-1,j+2) then
        hd(i,j,i-1,j)
        return true
    end
    --down
    if r(i,j)==r(i+1,j-2) and r(i,j)==r(i+1,j-1) and r(i,j)==r(i+1,j+1) and r(i,j)==r(i+1,j+2) then
        hd(i,j,i+1,j)
        return true
    end
    --right
    if r(i,j)==r(i-1,j+1) and r(i,j)==r(i-2,j+1) and r(i,j)==r(i+1,j+1) and r(i,j)==r(i+2,j+1) then
        hd(i,j,i,j+1)
        return true
    end
    --left
    if r(i,j)==r(i-2,j-1) and r(i,j)==r(i-1,j-1) and r(i,j)==r(i+1,j-1) and r(i,j)==r(i+2,j-1) then
        hd(i,j,i,j-1)
        return true
    end
    --5 end
    --up
    if (r(i,j)==r(i-1,j-2) and r(i,j)==r(i-1,j-1)) or (r(i,j)==r(i-3,j) and r(i,j)==r(i-2,j)) or (r(i,j)==r(i-1,j+1) and r(i,j)==r(i-1,j+2)) or (r(i,j)==r(i-1,j-1) and r(i,j)==r(i-1,j+1)) then
        hd(i,j,i-1,j)
        return true
    end
    --right
    if (r(i,j)==r(i-2,j+1) and r(i,j)==r(i-1,j+1)) or (r(i,j)==r(i,j+2) and r(i,j)==r(i,j+3)) or (r(i,j)==r(i+1,j+1) and r(i,j)==r(i+2,j+1)) or (r(i,j)==r(i-1,j+1) and r(i,j)==r(i+1,j+1)) then
        hd(i,j,i,j+1)
        return true
    end
    --bottom
    if (r(i,j)==r(i+1,j-2) and r(i,j)==r(i+1,j-1)) or (r(i,j)==r(i+1,j+1) and r(i,j)==r(i+1,j+2)) or (r(i,j)==r(i+1,j-1) and r(i,j)==r(i+1,j+1)) or (r(i,j)==r(i+2,j) and r(i,j)==r(i+3,j)) then
        hd(i,j,i+1,j)
        return true
    end
    --left
    if (r(i,j)==r(i-2,j-1) and r(i,j)==r(i-1,j-1)) or (r(i,j)==r(i+1,j-1) and r(i,j)==r(i+2,j-1)) or (r(i,j)==r(i-1,j-1) and r(i,j)==r(i+1,j-1)) or (r(i,j)==r(i,j-2) and r(i,j)==r(i,j-3)) then
        hd(i,j,i,j-1)
        return true
    end
    return false
end

function TestEnd()
    if (0x2c4025==getColor(175,965) and 0x2c4025==getColor(176,965)) or (0x344524==getColor(175,965) and 0x344524==getColor(176,965)) then
        return true
    elseif 0x70a237==getColor(250,800) or 0x4cbcb7==getColor(385,815) then
		logDebug("TestEnd - failed return")
		return true
	else
		--logDebug("---------------------------")
		--logDebug(string.format("0x2c4025==0x%x",getColor(175,965)))
		--logDebug(string.format("0x2c4025==0x%x",getColor(176,965)))
        return false
    end
end

function Working()
    CacheColor()
    for i=1,7 do
        for j=1,7 do
            if true==TestGrid(i,j) then
                return
            end
        end
    end
end

function TestAgain()
    while true do
        mSleep(500)
		--test again
        if (0xc94448==getColor(357,855) and 0xc94c4d==getColor(366,863)) or (0xfff7f9==getColor(350,848) and 0xfff0f2==getColor(400,858)) then
            mSleep(500)
            click(361,861)
            break
        end
		--test award
		if 0x70a237==getColor(250,800) or 0x4cbcb7==getColor(385,815) then
			mSleep(200)
			click(385,815)
			mSleep(200)
		end
    end
end

--main logic
while true do
    TestHeart()
    TestStart()
    TestReady()

    --working
    while true do
        Working()
        if true==TestEnd() then
            break
        else
            mSleep(workDelay)
        end
    end

    TestAgain()
    tempColor=0
end
