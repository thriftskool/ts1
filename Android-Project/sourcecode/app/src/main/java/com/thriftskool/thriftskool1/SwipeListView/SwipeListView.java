package com.thriftskool.thriftskool1.SwipeListView;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Message;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.os.Handler;
import android.widget.ListView;

//import java.util.logging.Handler;

public class SwipeListView extends ListView {
	private Boolean mIsHorizontal;
	private View mPreItemView;
	private View mCurrentItemView;
	public static float mFirstX;
	public static float mFirstY;
	public static int motionPosition=-1;
	public static int mRightViewWidth = 100;
	private final int mDuration = 100;
	private final int mDurationStep = 10;
	private boolean mIsShown;


	private boolean mIsFooterCanSwipe = false;

	private boolean mIsHeaderCanSwipe = false;

	public SwipeListView(Context context) {
		super(context);
	}

	public SwipeListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public SwipeListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	@Override
	public boolean onInterceptTouchEvent(MotionEvent ev) {
	//	float lastX = 24;
		
		float lastX = ev.getX();
		float lastY = ev.getY();
		
//		View currentItemView = getChildAt(0- getFirstVisiblePosition());
//		mPreItemView = mCurrentItemView;
//		mCurrentItemView = currentItemView;
		
		if(motionPosition>=0)
		{
			swipeOnClick(motionPosition,ev.getX(),ev.getY());
			
		}
		
		
		switch (ev.getAction()) {
		case MotionEvent.ACTION_DOWN:
			mIsHorizontal = null;

			break;

		case MotionEvent.ACTION_MOVE:
			
			break;

		case MotionEvent.ACTION_UP:
		case MotionEvent.ACTION_CANCEL:
		
			
			if (mIsShown) {
				hiddenRight(mPreItemView);
			}

			if (mIsHorizontal != null && mIsHorizontal) {
				if (mFirstX - lastX > mRightViewWidth / 2) {
					showRight(mCurrentItemView);
				} else {
					hiddenRight(mCurrentItemView);
				}

				return false;
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
		int selectPos = pointToPosition((int) posX, (int) posY);
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
		int selectPos = pointToPosition((int) posX, (int) posY);
		if (selectPos >= 0 && selectPos < getHeaderViewsCount()) {
			// is header ,can not swipe
			return false;
		}
		// not header can swipe
		return true;
	}

	@Override
	public boolean onTouchEvent(MotionEvent ev) {
		//float lastX = 24;
		float lastX = ev.getX();
		float lastY = ev.getY();
		
		
		
		// test footer and header
		if (!judgeFooterView(mFirstX, mFirstY)
				|| !judgeHeaderView(mFirstX, mFirstY)) {
			return super.onTouchEvent(ev);
		}
	
		switch (ev.getAction()) {
		

		

		case MotionEvent.ACTION_UP:
		case MotionEvent.ACTION_CANCEL:



			//clearPressedState();
			if (mIsShown) {
				hiddenRight(mPreItemView);
			}

			/*if (mIsHorizontal != null && mIsHorizontal) {
				if (mFirstX - lastX > mRightViewWidth / 2) {
					showRight(mCurrentItemView);
				} else {
					hiddenRight(mCurrentItemView);
				}

				return false;
			}*/
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
				view = (View) msg.obj;
				fromX = msg.arg1;
				toX = msg.arg2;
				stepX = (int) ((toX - fromX) * mDurationStep * 1.0 / mDuration);
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
			boolean isLastStep = (stepX > 0 && fromX > toX)
					|| (stepX < 0 && fromX < toX);
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
		SwipeListView.mRightViewWidth = mRightViewWidth;
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
	}


	public void swipeOnClick(int position,float dx, float dy)
	{

		View currentItemView = getChildAt(position- getFirstVisiblePosition());
		mPreItemView = mCurrentItemView;
		mCurrentItemView = currentItemView;
		mIsHorizontal=true;
		//mIsShown =true;



/*
			if (mIsHorizontal == null) {
				if (!judgeScrollDirection(dx, dy)) {
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
					mCurrentItemView.scrollTo((int) (-dx), 0);
				}

			} else {
				if (mIsShown) {
					hiddenRight(mPreItemView);
				}
			}
*/


		
	}

}
