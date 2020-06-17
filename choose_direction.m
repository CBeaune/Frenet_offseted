function n_lane = choose_direction(closest_ob,wx,wy)
  [s1 , d1] = getFrenet(closest_ob(1),closest_ob(2),wx,wy,0.0);
  if d1<0
    n_lane = "mid_to_left";
  else
    n_lane = "mid_to_right";
  endif
  endfunction