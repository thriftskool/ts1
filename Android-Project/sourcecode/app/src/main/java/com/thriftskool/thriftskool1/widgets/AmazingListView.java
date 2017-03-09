package com.thriftskool.thriftskool1.widgets;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Canvas;
import android.os.Handler;
import android.os.Message;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ListAdapter;
import android.widget.ListView;


/**
 * A ListView that maintains a header pinned at the top of the list. The
 * pinned header can be pushed up and dissolved as needed.
 * 
 * It also supports pagination by setting a custom view as the loading
 * indicator.
 */
public class AmazingListView extends ListView implements AmazingAdapter.HasMorePagesListener {
	public static final String TAG = AmazingListView.class.getSimpleName();
	
	View listFooter;
	boolean footerViewAttached = false;

    private View mHeaderView;
    private boolean mHeaderViewVisible;

    private int mHeaderViewWidth;
    private int mHeaderViewHeight;

    private AmazingAdapter adapter;
    
    private Boolean mIsHorizontal;
    private View mPreItemView;
    private View mCurrentItemView;
    private float mFirstX;
    private float mFirstY;
    public static int mRightViewWidth = 300;
    private final int mDuration = 100;
    private final int mDurationStep = 10;
    private boolean mIsShown;
    private boolean mIsFooterCanSwipe = false;
    private boolean mIsHeaderCanSwipe = false;
    
    public void setPinnedHeaderView(View view) {
        mHeaderView = view;

        // Disable vertical fading when the pinned header is present
        // TODO change ListView to allow separate measures for top and bottom fading edge;
        // in this particular case we would like to disable the top, but not the bottom edge.
        if (mHeaderView != null) {
            setFadingEdgeLength(0);
        }
        requestLayout();
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        if (mHeaderView != null) {
            measureChild(mHeaderView, widthMeasureSpec, heightMeasureSpec);
            mHeaderViewWidth = mHeaderView.getMeasuredWidth();
            mHeaderViewHeight = mHeaderView.getMeasuredHeight();
        }
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        if (mHeaderView != null) {
            mHeaderView.layout(0, 0, mHeaderViewWidth, mHeaderViewHeight);
            configureHeaderView(getFirstVisiblePosition());
        }
    }

    public void configureHeaderView(int position) {
        if (mHeaderView == null) {
            return;
        }

        int state = adapter.getPinnedHeaderState(position);
        switch (state) {
            case AmazingAdapter.PINNED_HEADER_GONE: {
                mHeaderViewVisible = false;
                break;
            }

            case AmazingAdapter.PINNED_HEADER_VISIBLE: {
            	adapter.configurePinnedHeader(mHeaderView, position, 255);
                if (mHeaderView.getTop() != 0) {
                    mHeaderView.layout(0, 0, mHeaderViewWidth, mHeaderViewHeight);
                }
                mHeaderViewVisible = true;
                break;
            }

            case AmazingAdapter.PINNED_HEADER_PUSHED_UP: {
                View firstView = getChildAt(0);
                if (firstView != null) {
	                int bottom = firstView.getBottom();
	                int headerHeight = mHeaderView.getHeight();
	                int y;
	                int alpha;
	                if (bottom < headerHeight) {
	                    y = (bottom - headerHeight);
	                    alpha = 255 * (headerHeight + y) / headerHeight;
	                } else {
	                    y = 0;
	                    alpha = 255;
	                }
	                adapter.configurePinnedHeader(mHeaderView, position, alpha);
	                if (mHeaderView.getTop() != y) {
	                    mHeaderView.layout(0, y, mHeaderViewWidth, mHeaderViewHeight + y);
	                }
	                mHeaderViewVisible = true;
                }
                break;
            }
        }
    }

    @Override
    protected void dispatchDraw(Canvas canvas) {
        super.dispatchDraw(canvas);
        if (mHeaderViewVisible) {
            drawChild(canvas, mHeaderView, getDrawingTime());
        }
    }
    
    
    public AmazingListView(Context context) {
        super(context);
    }

    public AmazingListView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public AmazingListView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }
    
    public void setLoadingView(View listFooter) {
		this.listFooter = listFooter;
	}
    
    public View getLoadingView() {
		return listFooter;
	}
    
    @Override
    public void setAdapter(ListAdapter adapter) {
    	if (!(adapter instanceof AmazingAdapter)) {
    		throw new IllegalArgumentException(AmazingListView.class.getSimpleName() + " must use adapter of type " + AmazingAdapter.class.getSimpleName());
    	}
    	
    	// previous adapter
    	if (this.adapter != null) {
    		this.adapter.setHasMorePagesListener(null);
    		this.setOnScrollListener(null);
    	}
    	
    	this.adapter = (AmazingAdapter) adapter;
    	((AmazingAdapter)adapter).setHasMorePagesListener(this);
		this.setOnScrollListener((AmazingAdapter) adapter);
    	
		View dummy = new View(getContext());
    	super.addFooterView(dummy);
    	super.setAdapter(adapter);
    	super.removeFooterView(dummy);
    }
    
    @Override
    public AmazingAdapter getAdapter() {
    	return adapter;
    }

	@Override
	public void noMorePages() {
		if (listFooter != null) {
			this.removeFooterView(listFooter);
		}
		footerViewAttached = false;
	}

	@Override
	public void mayHaveMorePages() {
		if (! footerViewAttached && listFooter != null) {
			this.addFooterView(listFooter);
			footerViewAttached = true;
		}
	}
	
	public boolean isLoadingViewVisible() {
		return footerViewAttached;
	}
	
	
	
/*
    @Override
    public boolean onInterceptTouchEvent(MotionEvent ev) {
        float lastX = ev.getX();
        float lastY = ev.getY();
        switch (ev.getAction()) {
            case MotionEvent.ACTION_DOWN:
                mIsHorizontal = null;
                mFirstX = lastX;
                mFirstY = lastY;
                int motionPosition = pointToPosition((int)mFirstX, (int)mFirstY);

                Log.e("Action Down ", "Action Down value: "+motionPosition);
                
                if (motionPosition >= 0) {
                	
                	   Log.e("Action Down ", "getFirstVisiblePosition Down value: "+getFirstVisiblePosition());
                       
                    View currentItemView = getChildAt(motionPosition - getFirstVisiblePosition());
                    mPreItemView = mCurrentItemView;
                    mCurrentItemView = currentItemView;
                }
                break;

            case MotionEvent.ACTION_MOVE:
                float dx = lastX - mFirstX;
                float dy = lastY - mFirstY;

                if (Math.abs(dx) >= 5 && Math.abs(dy) >= 5) {
                    return true;
                }
                break;

            case MotionEvent.ACTION_UP:
            case MotionEvent.ACTION_CANCEL:
                if (mIsShown && (mPreItemView != mCurrentItemView || isHitCurItemLeft(lastX))) {
                    System.out.println("1---> hiddenRight");
                   
                    hiddenRight(mPreItemView);
                }
                break;
        }

        return super.onInterceptTouchEvent(ev);
    }

    private boolean isHitCurItemLeft(float x) {
        return x < getWidth() - mRightViewWidth;
    }

   
    private boolean judgeScrollDirection(float dx, float dy) {
        boolean canJudge = true;

        if (Math.abs(dx) > 30 && Math.abs(dx) > 2 * Math.abs(dy)) {
            mIsHorizontal = true;
        } else if (Math.abs(dy) > 30 && Math.abs(dy) > 2 * Math.abs(dx)) {
            mIsHorizontal = false;
        } else {
            canJudge = false;
        }

        return canJudge;
    }

   
    private boolean judgeFooterView(float posX, float posY) {
        // if footer can swipe
        if (mIsFooterCanSwipe) {
            return true;
        }
        // footer cannot swipe
        int selectPos = pointToPosition((int)posX, (int)posY);
        if (selectPos >= (getCount() - getFooterViewsCount())) {
            // is footer ,can not swipe
            return false;
        }
        // not footer can swipe
        return true;
    }

  
    private boolean judgeHeaderView(float posX, float posY) {
        // if header can swipe
        if (mIsHeaderCanSwipe) {
            return true;
        }
        // header cannot swipe
        int selectPos = pointToPosition((int)posX, (int)posY);
        if (selectPos >= 0 && selectPos < getHeaderViewsCount()) {
            // is header ,can not swipe
            return false;
        }
        // not header can swipe
        return true;
    }

   
    @Override
    public boolean onTouchEvent(MotionEvent ev) {
        float lastX = ev.getX();
        float lastY = ev.getY();
        // test footer and header
        if (!judgeFooterView(mFirstX, mFirstY) || !judgeHeaderView(mFirstX, mFirstY)) {
            return super.onTouchEvent(ev);
        }
        switch (ev.getAction()) {
            case MotionEvent.ACTION_DOWN:
                break;

            case MotionEvent.ACTION_MOVE:
                float dx = lastX - mFirstX;
                float dy = lastY - mFirstY;
                // confirm is scroll direction
                if (mIsHorizontal == null) {
                    if (!judgeScrollDirection(dx, dy)) {
                        break;
                    }
                }

                if (mIsHorizontal) {
                    if (mIsShown && mPreItemView != mCurrentItemView) {
                       
                        hiddenRight(mPreItemView);
                    }

                    if (mIsShown && mPreItemView == mCurrentItemView) {
                        dx = dx - mRightViewWidth;
                    }

                    // can't move beyond boundary
                    if (dx < 0 && dx > -mRightViewWidth) {
                        mCurrentItemView.scrollTo((int)(-dx), 0);
                    }

                    return true;
                } else {
                    if (mIsShown) {
                      
                        hiddenRight(mPreItemView);
                    }
                }

                break;

            case MotionEvent.ACTION_UP:
            case MotionEvent.ACTION_CANCEL:
                clearPressedState();
                if (mIsShown) {
                   
                    hiddenRight(mPreItemView);
                }

                if (mIsHorizontal != null && mIsHorizontal) {
                    if (mFirstX - lastX > mRightViewWidth / 2) {
                        showRight(mCurrentItemView);
                    } else {
                      
                        hiddenRight(mCurrentItemView);
                    }

                    return true;
                }

                break;
        }

        return super.onTouchEvent(ev);
    }

    private void clearPressedState() {
        // TODO current item is still has background, issue
        mCurrentItemView.setPressed(false);
        setPressed(false);
        refreshDrawableState();
        // invalidate();
    }

    private void showRight(View view) {
        Message msg = new MoveHandler().obtainMessage();
        msg.obj = view;
        msg.arg1 = view.getScrollX();
        msg.arg2 = mRightViewWidth;
        msg.sendToTarget();

        mIsShown = true;
    }

    private void hiddenRight(View view) {
        if (mCurrentItemView == null) {
            return;
        }
        Message msg = new MoveHandler().obtainMessage();//
        msg.obj = view;
        msg.arg1 = view.getScrollX();
        msg.arg2 = 0;

        msg.sendToTarget();

        mIsShown = false;
    }

  
    @SuppressLint("HandlerLeak")
    class MoveHandler extends Handler {
        int stepX = 0;

        int fromX;

        int toX;

        View view;

        private boolean mIsInAnimation = false;

        private void animatioOver() {
            mIsInAnimation = false;
            stepX = 0;
        }

        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            if (stepX == 0) {
                if (mIsInAnimation) {
                    return;
                }
                mIsInAnimation = true;
                view = (View)msg.obj;
                fromX = msg.arg1;
                toX = msg.arg2;
                stepX = (int)((toX - fromX) * mDurationStep * 1.0 / mDuration);
                if (stepX < 0 && stepX > -1) {
                    stepX = -1;
                } else if (stepX > 0 && stepX < 1) {
                    stepX = 1;
                }
                if (Math.abs(toX - fromX) < 10) {
                    view.scrollTo(toX, 0);
                    animatioOver();
                    return;
                }
            }

            fromX += stepX;
            boolean isLastStep = (stepX > 0 && fromX > toX) || (stepX < 0 && fromX < toX);
            if (isLastStep) {
                fromX = toX;
            }

            view.scrollTo(fromX, 0);
            invalidate();

            if (!isLastStep) {
                this.sendEmptyMessageDelayed(0, mDurationStep);
            } else {
                animatioOver();
            }
        }
    }

    public int getRightViewWidth() {
        return mRightViewWidth;
    }

    public void setRightViewWidth(int mRightViewWidth) {
        this.mRightViewWidth = mRightViewWidth;
    }

   
    public void setFooterViewCanSwipe(boolean canSwipe) {
        mIsFooterCanSwipe = canSwipe;
    }

    public void setHeaderViewCanSwipe(boolean canSwipe) {
        mIsHeaderCanSwipe = canSwipe;
    }

    public void setFooterAndHeaderCanSwipe(boolean footer, boolean header) {
        mIsHeaderCanSwipe = header;
        mIsFooterCanSwipe = footer;
    }*/

}
